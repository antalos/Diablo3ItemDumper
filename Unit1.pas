unit Unit1;

interface

uses
  functions, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, mem_reader, ClipBrd, ShellApi, AppEvnts, translator, d3const, d3ui;

const
  WM_NOTIFYICON  = WM_USER+333;


type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Button1: TButton;
    ApplicationEvents1: TApplicationEvents;
    cbTranslate: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);

  private
    { Private declarations }
    tnid: TNotifyIconData;
    HMainIcon: HICON;

    procedure CMClickIcon(var msg: TMessage); message WM_NOTIFYICON;
    procedure WMHotkey( var msg: TWMHotkey ); message WM_HOTKEY;

  public
    { Public declarations }
  end;

  THashRec = record
    hash1, hash2 : dword;
  end;




var
  Form1: TForm1;

  hashrec : array[0..1024] of THashRec;
  client_hwnd : hwnd;

const

  CUR_VERSION = '104e';


  procedure log(s:string);



implementation

{$R *.dfm}

procedure TForm1.CMClickIcon(var msg: TMessage);
begin
  case msg.lparam of
    WM_LBUTTONDOWN : begin
      Application.RestoreTopMosts;
      WindowState := wsNORMAL;

      Visible := true;
      Show;
      self.Activate;
      windows.SetFocus(self.Handle);
      SetForegroundWindow(self.Handle);
      application.BringToFront();

    end;
  end;
end;


procedure log(s:string);
begin
  form1.Memo1.Lines.Add(s);
end;








procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
//  Action := caNone;
//  Hide;
Visible := false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dump_ui();
end;



procedure TForm1.FormCreate(Sender: TObject);
var s : string;
begin
  top := 10;
  left := screen.Width - width - 10;
  memo1.Lines.Clear();

  if not RegisterHotkey(Handle, 1, 0, VK_F11) then begin
    log('[ERROR] Unable to assign f11 as hotkey.');
  end;

  if not RegisterHotkey(Handle, 2, MOD_CONTROL, VK_F11) then begin
    log('[ERROR] Unable to assign ctrl+f11 as hotkey.');
  end;

 {* client_hwnd := HWND(FindWindow(nil, PChar('Diablo III')));
  if not(IsWindow(client_hwnd)) then client_hwnd := 0;

  log('ver: ' + CUR_VERSION);
  if client_hwnd <> 0 then begin
    mr := CMem_reader.create(  );
    mr.attach( client_hwnd );
  end else begin
    log('[ERROR] d3 not found');
    exit;
  end;
  *}

  label1.Caption := 'Press F11 while the cursor is over item - the item info should '#13#10'be copied to clipboard and it will also apper in textbox below'#13#10'use ctrl+F11 to dump character''s stats';
  label1.Caption := label1.Caption+#13#10#13#10'my skype: antalos22';
  label1.Caption := label1.Caption+#13#10#13#10'kudos to leprosorium.ru';

  HMainIcon                := LoadIcon(MainInstance, 'MAINICON');

  Shell_NotifyIcon(NIM_DELETE, @tnid);

  tnid.cbSize              := sizeof(TNotifyIconData);
  tnid.Wnd                 := handle;
  tnid.uID                 := 123;
  tnid.uFlags              := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  tnid.uCallbackMessage    := WM_NOTIFYICON;
  tnid.hIcon               := HMainIcon;
  tnid.szTip               := 'POP3 Server';

  Shell_NotifyIcon(NIM_ADD, @tnid);

  memo1.Lines.Add('ver: '+CUR_VERSION);
//  memo1.Lines.Clear();
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
 Shell_NotifyIcon(NIM_DELETE, @tnid);
end;




procedure TForm1.WMHotkey( var msg: TWMHotkey );
  var s : string;
begin
  if msg.hotkey = 1 then
  begin
    //Button1Click(self);

    //dump_ui();    exit;
    s := get_info_from_itempopup();
    log( s );
    log('-----------------------');
    Clipboard.AsText := s;
    exit;
  end;

  if msg.hotkey = 2 then
  begin
    //s := get_short_charinfo();
    s := get_full_charinfo();
    log( s );
    log('-----------------------');
    Clipboard.AsText := s;
    exit;
  end;

end;

end.
