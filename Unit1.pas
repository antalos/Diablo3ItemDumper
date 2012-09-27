unit Unit1;

interface

uses
  functions, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Menus,
  Dialogs, StdCtrls, mem_reader, ClipBrd, ShellApi, AppEvnts, translator,
  d3const, d3ui,
  ComCtrls, IniFiles;

const
  WM_NOTIFYICON = WM_USER + 333;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Button1: TButton;
    ApplicationEvents1: TApplicationEvents;
    cbTranslate: TCheckBox;
    hkDumpItem: THotKey;
    Button2: TButton;
    hkDumpChar: THotKey;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
    tnid: TNotifyIconData;
    HMainIcon: HICON;

    procedure CMClickIcon(var msg: TMessage); message WM_NOTIFYICON;
    procedure WMHotkey(var msg: TWMHotkey); message WM_HOTKEY;

  public
    { Public declarations }
  end;

  THashRec = record
    hash1, hash2: dword;
  end;

var
  Form1: TForm1;

  hashrec: array [0 .. 1024] of THashRec;
  client_hwnd: hwnd;

const

  CUR_VERSION = '104f';

procedure log(s: string);

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  s, ibind, cbind: string;
  f : TIniFile;
  Shortcut: TShortCut;
  Flags: Cardinal;
  Key  : Word;
  Shift : TShiftState;
begin
  top := 10;
  left := screen.Width - Width - 10;
  Memo1.Lines.Clear();

  Label1.Caption :=
    'Press F11 while the cursor is over item - the item info should '#13#10'be copied to clipboard and it will also apper in textbox below'#13#10'use ctrl+F11 to dump character''s stats';
  Label1.Caption := Label1.Caption + #13#10#13#10'my skype: antalos22';
  Label1.Caption := Label1.Caption + #13#10#13#10'kudos to leprosorium.ru';

  HMainIcon := LoadIcon(MainInstance, 'MAINICON');

  Shell_NotifyIcon(NIM_DELETE, @tnid);

  tnid.cbSize := sizeof(TNotifyIconData);
  tnid.Wnd := Handle;
  tnid.uID := 123;
  tnid.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  tnid.uCallbackMessage := WM_NOTIFYICON;
  tnid.HICON := HMainIcon;
  tnid.szTip := 'POP3 Server';

  Shell_NotifyIcon(NIM_ADD, @tnid);

  Memo1.Lines.Add('ver: ' + CUR_VERSION);
  // memo1.Lines.Clear();

  f := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\app.ini');
  ibind  := f.ReadString('common', 'itemDumpKey', 'f11');
  cbind := f.ReadString('common', 'charDumpKey', 'Ctrl+f11');
  f.Free;

  hkDumpItem.HotKey := TextToShortCut( ibind );
  hkDumpChar.HotKey := TextToShortCut( cbind );

  ShortCut := TextToShortCut(ibind);
  Flags := 0;
  Key   := 0;
  Shift  := [];
  ShortCutToKey(Shortcut, Key, Shift);
  if ssCtrl in Shift then Flags := Flags or MOD_CONTROL;
  if ssShift in Shift then Flags := Flags or MOD_SHIFT;
  if ssAlt in Shift then  Flags := Flags or MOD_ALT;
  if not RegisterHotkey(Handle, 1, Flags, Key) then log('[ERROR] Unable to assign '+ibind+' as hotkey.');

  ShortCut := TextToShortCut(cbind);
  Flags := 0;
  Key   := 0;
  Shift  := [];
  ShortCutToKey(Shortcut, Key, Shift);
  if ssCtrl in Shift then Flags := Flags or MOD_CONTROL;
  if ssShift in Shift then Flags := Flags or MOD_SHIFT;
  if ssAlt in Shift then  Flags := Flags or MOD_ALT;
  if not RegisterHotkey(Handle, 2, Flags, Key) then log('[ERROR] Unable to assign '+cbind+' as hotkey.');


end;


procedure TForm1.Button2Click(Sender: TObject);
var  f : TIniFile;
begin
  f := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'app.ini');
  f.writeString('common', 'itemDumpKey', ShortCutToText( hkDumpItem.HotKey ));
  f.writeString('common', 'charDumpKey', ShortCutToText( hkDumpChar.HotKey ));
  f.Free;

  log('!!! WARN !!!! New hotkeys will work after program restart')
end;


procedure TForm1.CMClickIcon(var msg: TMessage);
begin
  case msg.lparam of
    WM_LBUTTONDOWN:
      begin
        Application.RestoreTopMosts;
        WindowState := wsNORMAL;

        Visible := true;
        Show;
        self.Activate;
        Windows.SetFocus(self.Handle);
        SetForegroundWindow(self.Handle);
        Application.BringToFront();

      end;
  end;
end;

procedure log(s: string);
begin
  Form1.Memo1.Lines.Add(s);
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  // Action := caNone;
  // Hide;
  Visible := false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dump_ui();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @tnid);
end;

procedure TForm1.WMHotkey(var msg: TWMHotkey);
var
  s: string;
begin
  if msg.hotkey = 1 then
  begin
    // Button1Click(self);

    // dump_ui();    exit;
    s := get_info_from_itempopup();
    log(s);
    log('-----------------------');
    Clipboard.AsText := s;
    exit;
  end;

  if msg.hotkey = 2 then
  begin
    // s := get_short_charinfo();
    s := get_full_charinfo();
    log(s);
    log('-----------------------');
    Clipboard.AsText := s;
    exit;
  end;

end;

end.
