unit functions;
interface
uses math, windows, SysUtils;


function sHex(i : dword) : string;
function sInt(i : longint) : string;
function sfloat(i : double) : string;


function RadianToDegree(Rotation:Single) : Single;
function IntToBinStr(const x: integer): string;
function UnixTime(): Longint;
Function atan2(y : extended; x : extended): extended;
function max(a,b:integer):integer;
function EncodeBase64(const inStr: string): string;

procedure stringsToArray(s : string; delimiter: string; var a : array of string; var n : word);

function get_bind(b : string) : word;
procedure log(s: string);
function read(addr :dword) : dword;

function getfloat(s:string) : double	;

implementation
uses unit1;

function sfloat(i : double) : string;
begin
  DecimalSeparator  := '.';
  result := FloatToStr( i );
end;

function getfloat(s:string) : double ;
begin
  DecimalSeparator := '.';
  result := strtoFloat(s);
end;


function read(addr : dword) : dword;
begin
  result := mr.readUInt( addr );
end;

procedure log(s: string);
begin
  form1.Memo1.Lines.Add(s);
end;

function sHex(i : dword) : string;
begin
  result := ''+inttohex(i, 6);
end;

function sInt(i : longint) : string;
begin
  result := inttostr(i);
end;

function max(a,b:integer):integer;
begin
  result := b;
  if a>b then result := a;

end;

function IntToBinStr(const x: integer): string;
var
   i, n: integer;
begin
   n := Sizeof(X) * 8;
   SetLength(Result, n);
   for i := 0 to n - 1 do
     Result[n - i] := Chr(Ord('0') + Sign(X and (1 shl i)));
end;

function RadianToDegree(Rotation:Single) : Single;
begin
  try
    result := (Rotation * (180 / pi));
  except
    result := 0;
  end;
end;


function UnixTime(): Longint;
const
  UnixStartDate: TDateTime = 25569.0;
begin
  Result := Round((now() - UnixStartDate) * 86400);
end;

Function atan2(y : extended; x : extended): extended;
Assembler;
asm
  fld [y]
  fld [x]
  fpatan
end;



//turning string into array of strings
procedure stringsToArray(s : string; delimiter: string; var a : array of string; var n : word);
  var i : integer;
      r : string;
begin
 n := 0;
 r := delimiter;
 for i:=1 to High(A) do a[i] := '';

 while s <> '' do begin
    i := Pos(r,s);
    if i=0 then i := Length(s) + 1;
    a[n] := trim(Copy(s,1,i-1));
    Delete(s,1,i+length(r)-1);
    inc(n);
 end;
end;


function get_bind(b : string) : word;
begin
result := 0;
if b = 'LBUTTON' then result := VK_LBUTTON;
if b = 'RBUTTON' then result := VK_RBUTTON;
if b = 'CANCEL' then result := VK_CANCEL;
if b = 'XBUTTON1' then result := VK_XBUTTON1;
if b = 'XBUTTON2' then result := VK_XBUTTON2;
if b = 'BACK' then result := VK_BACK;
if b = 'TAB' then result := VK_TAB;
if b = 'CLEAR' then result := VK_CLEAR;
if b = 'RETURN' then result := VK_RETURN;
if b = 'SHIFT' then result := VK_SHIFT;
if b = 'CONTROL' then result := VK_CONTROL;
if b = 'MENU' then result := VK_MENU;
if b = 'PAUSE' then result := VK_PAUSE;
if b = 'CAPITAL' then result := VK_CAPITAL;
if b = 'KANA' then result := VK_KANA;
if b = 'HANGUL' then result := VK_HANGUL;
if b = 'JUNJA' then result := VK_JUNJA;
if b = 'FINAL' then result := VK_FINAL;
if b = 'HANJA' then result := VK_HANJA;
if b = 'KANJI' then result := VK_KANJI;
if b = 'CONVERT' then result := VK_CONVERT;
if b = 'NONCONVERT' then result := VK_NONCONVERT;
if b = 'ACCEPT' then result := VK_ACCEPT;
if b = 'MODECHANGE' then result := VK_MODECHANGE;
if b = 'ESCAPE' then result := VK_ESCAPE;
if b = 'SPACE' then result := VK_SPACE;
if b = 'PRIOR' then result := VK_PRIOR;
if b = 'NEXT' then result := VK_NEXT;
if b = 'END' then result := VK_END;
if b = 'HOME' then result := VK_HOME;
if b = 'LEFT' then result := VK_LEFT;
if b = 'UP' then result := VK_UP;
if b = 'RIGHT' then result := VK_RIGHT;
if b = 'DOWN' then result := VK_DOWN;
if b = 'SELECT' then result := VK_SELECT;
if b = 'PRINT' then result := VK_PRINT;
if b = 'EXECUTE' then result := VK_EXECUTE;
if b = 'SNAPSHOT' then result := VK_SNAPSHOT;
if b = 'INSERT' then result := VK_INSERT;
if b = 'DELETE' then result := VK_DELETE;
if b = 'HELP' then result := VK_HELP;
if b = 'LWIN' then result := VK_LWIN;
if b = 'RWIN' then result := VK_RWIN;
if b = 'APPS' then result := VK_APPS;
if b = 'SLEEP' then result := VK_SLEEP;
if b = 'NUMPAD0' then result := VK_NUMPAD0;
if b = 'NUMPAD1' then result := VK_NUMPAD1;
if b = 'NUMPAD2' then result := VK_NUMPAD2;
if b = 'NUMPAD3' then result := VK_NUMPAD3;
if b = 'NUMPAD4' then result := VK_NUMPAD4;
if b = 'NUMPAD5' then result := VK_NUMPAD5;
if b = 'NUMPAD6' then result := VK_NUMPAD6;
if b = 'NUMPAD7' then result := VK_NUMPAD7;
if b = 'NUMPAD8' then result := VK_NUMPAD8;
if b = 'NUMPAD9' then result := VK_NUMPAD9;
if b = 'MULTIPLY' then result := VK_MULTIPLY;
if b = 'ADD' then result := VK_ADD;
if b = 'SEPARATOR' then result := VK_SEPARATOR;
if b = 'SUBTRACT' then result := VK_SUBTRACT;
if b = 'DECIMAL' then result := VK_DECIMAL;
if b = 'DIVIDE' then result := VK_DIVIDE;
if b = 'F1' then result := VK_F1;
if b = 'F2' then result := VK_F2;
if b = 'F3' then result := VK_F3;
if b = 'F4' then result := VK_F4;
if b = 'F5' then result := VK_F5;
if b = 'F6' then result := VK_F6;
if b = 'F7' then result := VK_F7;
if b = 'F8' then result := VK_F8;
if b = 'F9' then result := VK_F9;
if b = 'F10' then result := VK_F10;
if b = 'F11' then result := VK_F11;
if b = 'F12' then result := VK_F12;
if b = 'F13' then result := VK_F13;
if b = 'F14' then result := VK_F14;
if b = 'F15' then result := VK_F15;
if b = 'F16' then result := VK_F16;
if b = 'F17' then result := VK_F17;
if b = 'F18' then result := VK_F18;
if b = 'F19' then result := VK_F19;
if b = 'F20' then result := VK_F20;
if b = 'F21' then result := VK_F21;
if b = 'F22' then result := VK_F22;
if b = 'F23' then result := VK_F23;
if b = 'F24' then result := VK_F24;
if b = 'NUMLOCK' then result := VK_NUMLOCK;
if b = 'SCROLL' then result := VK_SCROLL;
if b = 'LSHIFT' then result := VK_LSHIFT;
if b = 'RSHIFT' then result := VK_RSHIFT;
if b = 'LCONTROL' then result := VK_LCONTROL;
if b = 'RCONTROL' then result := VK_RCONTROL;
if b = 'LMENU' then result := VK_LMENU;
if b = 'RMENU' then result := VK_RMENU;
if b = 'BROWSER_BACK' then result := VK_BROWSER_BACK;
if b = 'BROWSER_FORWARD' then result := VK_BROWSER_FORWARD;
if b = 'BROWSER_REFRESH' then result := VK_BROWSER_REFRESH;
if b = 'BROWSER_STOP' then result := VK_BROWSER_STOP;
if b = 'BROWSER_SEARCH' then result := VK_BROWSER_SEARCH;
if b = 'BROWSER_FAVORITES' then result := VK_BROWSER_FAVORITES;
if b = 'BROWSER_HOME' then result := VK_BROWSER_HOME;
if b = 'VOLUME_MUTE' then result := VK_VOLUME_MUTE;
if b = 'VOLUME_DOWN' then result := VK_VOLUME_DOWN;
if b = 'VOLUME_UP' then result := VK_VOLUME_UP;
if b = 'MEDIA_NEXT_TRACK' then result := VK_MEDIA_NEXT_TRACK;
if b = 'MEDIA_PREV_TRACK' then result := VK_MEDIA_PREV_TRACK;
if b = 'MEDIA_STOP' then result := VK_MEDIA_STOP;
if b = 'MEDIA_PLAY_PAUSE' then result := VK_MEDIA_PLAY_PAUSE;
if b = 'LAUNCH_MAIL' then result := VK_LAUNCH_MAIL;
if b = 'LAUNCH_MEDIA_SELECT' then result := VK_LAUNCH_MEDIA_SELECT;
if b = 'LAUNCH_APP1' then result := VK_LAUNCH_APP1;
if b = 'LAUNCH_APP2' then result := VK_LAUNCH_APP2;
if b = 'OEM_1' then result := VK_OEM_1;
if b = 'OEM_PLUS' then result := VK_OEM_PLUS;
if b = 'OEM_COMMA' then result := VK_OEM_COMMA;
if b = 'OEM_MINUS' then result := VK_OEM_MINUS;
if b = 'OEM_PERIOD' then result := VK_OEM_PERIOD;
if b = 'OEM_2' then result := VK_OEM_2;
if b = 'OEM_3' then result := VK_OEM_3;
if b = 'OEM_4' then result := VK_OEM_4;
if b = 'OEM_5' then result := VK_OEM_5;
if b = 'OEM_6' then result := VK_OEM_6;
if b = 'OEM_7' then result := VK_OEM_7;
if b = 'OEM_8' then result := VK_OEM_8;
if b = 'OEM_102' then result := VK_OEM_102;
if b = 'PACKET' then result := VK_PACKET;
if b = 'PROCESSKEY' then result := VK_PROCESSKEY;
if b = 'ATTN' then result := VK_ATTN;
if b = 'CRSEL' then result := VK_CRSEL;
if b = 'EXSEL' then result := VK_EXSEL;
if b = 'EREOF' then result := VK_EREOF;
if b = 'PLAY' then result := VK_PLAY;
if b = 'ZOOM' then result := VK_ZOOM;
if b = 'NONAME' then result := VK_NONAME;
if b = 'PA1' then result := VK_PA1;
if b = 'OEM_CLEAR' then result := VK_OEM_CLEAR;
if length( AnsiString(b) ) = 1 then begin
 result := VkKeyScanA( AnsiChar( b[1] ) );
end;


end;


function EncodeBase64(const inStr: string): string;

  function Encode_Byte(b: Byte): Ansichar;
  const
    Base64Code: string[64] =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./';
  begin
    Result := Base64Code[ (b and $3F)+1 ];
  end;

var
  i: Integer;
begin
  i := 1;
  Result := '';
  while i <=Length(InStr) do
  begin
    Result := Result + Encode_Byte(Byte(inStr[i]) shr 2);
    Result := Result + Encode_Byte((Byte(inStr[i]) shl 4) or (Byte(inStr[i+1]) shr 4));
    if i+1 <=Length(inStr) then
      Result := Result + Encode_Byte((Byte(inStr[i+1]) shl 2) or (Byte(inStr[i+2]) shr 6))
    else
      Result := Result + '=';
    if i+2 <=Length(inStr) then
      Result := Result + Encode_Byte(Byte(inStr[i+2]))
    else
      Result := Result + '=';
    Inc(i, 3);
  end;
end;




end.
