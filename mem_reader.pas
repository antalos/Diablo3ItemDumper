unit mem_reader;

interface
uses sysutils, windows, NTNative, dialogs;


type


  CMem_reader = class
  private
    hProc : Thandle;
    mem_baseaddr : dword;

    procedure str_to_byte_array(pattern : string; var my_pattern : array of byte);

  public
    attached : boolean;
    last_error : string;

    procedure attach(client_hwnd : hwnd);
    procedure detach();
    function readUInt(addr : dword) : dword;
    function readInt(addr : dword) : Integer;
    function ReadFloat(addr : dword) : Single;


    function readLong(addr : dword) : Int64;
    function readUnicodeString (addr : dword) : string;
    function readASCIIString(addr : dword) : string;
    function readLongString(addr : dword) : string;

    function ReadByte(addr : dword) : byte;

    procedure writeByte(addr : dword; value : byte);
    procedure writeDword(addr, value : dword);
    procedure writeASCIIString(addr: dword ; value : ansistring);


    procedure readBytes(addr : dword; size : cardinal; var buf : array of byte);

    procedure search_pattern(buf, pattern : array of byte; mask : string; buf_size, pattern_size : cardinal; var n_matches : word; var matches : array of dword; start : dword);
    procedure search_for_chats();
    procedure test_pages();
  end;

function EnableDebugPrivilege(pid : THandle; const Value: Boolean): Boolean;

implementation

uses functions;


//**** Read DWORD
function CMem_reader.readUInt(addr : dword) : dword;
var
  dwReaded: DWord;
  buf: dword;
begin
 buf := 0;
 try
    ReadProcessMemory(hProc, ptr(addr), @buf, 4, dwReaded);
 except
 end;
 result := buf;
end;

function CMem_reader.readInt(addr : dword) : Integer;
var
  dwReaded: DWord;
  buf: Integer;
begin
 buf := 0;
 try
    ReadProcessMemory(hProc, ptr(addr), @buf, 4, dwReaded);
 except
 end;
 result := buf;
end;

function CMem_reader.ReadFloat(addr : dword) : Single;

  procedure SingleAsDWORD(var outSingle : Single; inDWORD : DWORD);
  begin
    try
      CopyMemory(@outSingle, @inDWORD, 4);
    except
    end;
  end;

var
  dwReaded: DWord;
  buf: dword;
  rs : single;
begin
 buf := 0;
 rs := 0;
 try
    ReadProcessMemory(hProc, ptr(addr), @buf, 4, dwReaded);
 except
 end;
 if (buf<> 0) then SingleAsDWORD(rs, buf);
 result := rs;
end;


function CMem_reader.readLong(addr : dword) : Int64;
var
  dwReaded: DWord;
  buf: Int64;
begin
 buf := 0;
 try
    ReadProcessMemory(hProc, ptr(addr), @buf, 16, dwReaded);
 except
 end;
 result := buf;
end;

//**** Read Unicode string
function CMem_reader.readUnicodeString (addr : dword) : string;
var
  dwReaded: DWord;
  buf : array[0..1] of byte;
  s : string;
  n : byte;
begin
  s := '';
  n := 0;
  while (true) do begin
   try
      ReadProcessMemory(hProc, ptr(addr+n*2), @buf, 2, dwReaded);
      if (buf[0] = 0) and (buf[1] = 0) then begin
        break;
      end else begin
        s := s + chr(buf[0]);
        inc(n);
        if (n>240) then break;
      end;
   except
   end;
  end;
  result := s;

  exit;
end;


function CMem_reader.readASCIIString(addr : dword) : string;
var
  dwReaded: DWord;
  buf : byte;
  s : RawByteString;
  i : byte;
  is_good : boolean;
begin
  s := '';
  for i:=0 to 250 do begin
    buf := 0;
    is_good := ReadProcessMemory(hProc, ptr(addr+i), @buf, 1, dwReaded);
    if (buf = 0) or not(is_good) then break;
    s := s + Ansichar(buf);
  end;
  result := UTF8ToString(s);
  exit;
end;

function CMem_reader.readLongString(addr : dword) : string;
var
  dwReaded: DWord;
  buf : byte;
  s : RawByteString;
  i : integer;
  is_good : boolean;
begin
  s := '';
  for i:=0 to 1024 do begin
    buf := 0;
    is_good := ReadProcessMemory(hProc, ptr(addr+i), @buf, 1, dwReaded);
    if (buf = 0) or not(is_good) then break;
    s := s + Ansichar(buf);
  end;
//  result := s;
  result := UTF8ToString(s);
  exit;
end;

function CMem_reader.ReadByte(addr : dword) : byte;
var
  dwReaded: DWord;
  buf : byte;
begin
  buf := 0;
  try
    ReadProcessMemory(hProc, ptr(addr), @buf, 1, dwReaded);
  except
  end;

  result := buf;
  exit;
end;

procedure CMem_reader.writeByte(addr : dword; value : byte);
var
  dwReaded: DWord;
begin
  WriteProcessMemory(hProc, ptr(addr), @value, 4, dwReaded);
end;

procedure CMem_reader.writeDword(addr, value : dword);
var
  dwReaded: DWord;
begin
  WriteProcessMemory(hProc, ptr(addr), @value, 4, dwReaded);
end;

procedure CMem_reader.writeASCIIString(addr: dword ; value : ansistring);
var
  dwReaded: DWord;
  s : PChar;
begin
  value := value + chr(0);
  s := Pchar(value);
  WriteProcessMemory(hProc, ptr(addr), PAnsiChar(value), length(value), dwReaded);
end;


procedure CMem_reader.readBytes(addr : dword; size : cardinal; var buf : array of byte);
var
  dwReaded : dword;
  is_good : boolean;
begin
  try
    is_good := ReadProcessMemory(hProc, ptr(addr), @buf, size, dwReaded);
    if not(is_good) then begin
      log('errar at 0x'+inttohex(addr, 8));
    end
    else begin
    //dlog('ok at 0x'+inttohex(addr, 8));

    end;
  except
    log('except');
  end;

end;


//**** Attach to process
procedure CMem_reader.attach(client_hwnd : hwnd);


{function test(ibase:pointer):boolean;
  var pfh:PIMAGEFILEHEADER;
  poh:PIMAGEOPTIONALHEADER;
  psh:PIMAGESECTIONHEADER;

   mzhead:PIMAGEDOSHEADER;
 pehead:PIMAGEOPTIONALHEADER;
begin
 result:=false;
 mzhead:=ibase;
 pehead:=pointer(mzhead^._lfanew+dword(ibase));
 if (mzhead^.e_magic<>IMAGE_DOS_SIGNATURE) or (pehead^.Magic<>IMAGE_NT_SIGNATURE) then exit;
 pfh:=pointer(pehead);
 pfh:=pointer(dword(pfh)+4);
 poh:=pointer(dword(pfh)+sizeof(_IMAGE_FILE_HEADER)  );

// if poh^.Magic<>IMAGE_NT_OPTIONAL_HDR32_MAGIC then exit;
// psh:=pointer(dword(poh)+sizeof(_IMAGE_OPTIONAL_HEA  DER));
 result:=true;
end;}


var
  hWn: HWND;
  PID: DWord;
  baseAddress : dword;
  FileName : string;

 pProcBasicInfo:PROCESS_BASIC_INFORMATION;
 ReturnLength:DWORD;
 prb:PEB;
 cb:cardinal;
// ProcessParameters:PROCESS_PARAMETERS;
// ws:WideString;
begin
  mem_baseaddr := 0;
  attached := false;
  if attached then exit;
  hWn := client_hwnd;


//  log('123');
  If IsWindow(hWn) Then
  Begin
    GetWindowThreadProcessId(hWn, @PID);
//    hProc := OpenProcess(PROCESS_VM_READ, False, PID);
//    hProc := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ or PROCESS_VM_OPERATION, False, PID);
    EnableDebugPrivilege(GetCurrentProcess(),  true);

    hProc := OpenProcess(PROCESS_ALL_ACCESS, False, PID);
    EnableDebugPrivilege(hProc,  true);
    If (hProc <> 0) Then
    Begin
      attached := true;
       try
         if (NtQueryInformationProcess(hProc,ProcessBasicInformation,@pProcBasicInfo,sizeof(PROCESS_BASIC_INFORMATION),@ReturnLength) = STATUS_SUCCESS) then
         begin
           if ReadProcessMemory(hProc,pProcBasicInfo.PebBaseAddress,@prb,sizeof(PEB),cb) then begin
            baseAddress := dword( pointer(prb.ImageBaseAddress) );
            mem_baseaddr := baseAddress;
//            log('d3 BaseAddr: '+inttohex(baseAddress, 8));
           end;
         end;
       except

       end;

    end else begin
      last_error := 'OpenProcess failed';
    end;
  end else begin
    last_error := 'win not found';
  end;

  if mem_baseaddr = 0 then begin
    last_error := 'Error getting baseAddr';
    attached := false;
  end;
end;

//**** detach from process
procedure CMem_reader.detach();
begin
  CloseHandle(hProc);
End;

procedure CMem_reader.str_to_byte_array(pattern : string; var my_pattern : array of byte);
var
  i,n : integer;
  s : string;
begin
  n := 0;
  for i:=1 to length(pattern) do begin
    if (pattern[i]=' ') then begin
      my_pattern[n] := strtoint('$'+s);
      s := '';
      inc(n);
    end
    else if i = length(pattern) then begin
      s := s + pattern[i];
      my_pattern[n] := strtoint('$'+s);
    end else begin
      s := s + pattern[i];
    end;
  end;
end;


procedure CMem_reader.search_pattern(buf, pattern : array of byte; mask : string; buf_size, pattern_size : cardinal; var n_matches : word; var matches : array of dword; start:dword);
  var i, j : dword;
      pattern_found : boolean;
begin
    for i:=1 to high(matches) do matches[i] := 0;
    n_matches := 0;
    
    for i:=0 to buf_size-1 do begin
      pattern_found := true;
      if (buf[i] = pattern[0]) then begin
        for j:=0 to pattern_size do begin
          if (mask[j+1] = 'x') and (buf[i+j] <> pattern[j])
          then begin
            pattern_found := false;
            break;
          end;
        end;
        if (pattern_found) then begin
          inc(n_matches);
          matches[n_matches-1] := i;
          //dout('found at '+IntToHex(start+i, 8));
        end;
      end;
    end;

end;


//min pattern length = 3
procedure bin_BMSearch(StartPos: Integer; const S, P: array of byte; start : dword);
type
  TBMTable = array[0..255] of Integer;
var
  Pos, lp, i: Integer;
  BMT: TBMTable;
 // tmp, resaddr : dword;

begin

  for i := 0 to 255 do
    BMT[i] := Length(P)-1;

  for i := Length(P)-1 downto 0 do
    if BMT[P[i]] = Length(P)-1 then
      BMT[P[i]] := Length(P) -1 - i;

  lp := Length(P)-1;
  Pos := StartPos + lp  - 1;
  while Pos <= Length(S)-1 do
    if P[lp] <> S[Pos] then
      Pos := Pos + BMT[S[Pos]]
    else if lp = 0 then
    begin
      Exit;
    end
    else
      for i := lp - 1 downto 0 do
        if P[i] <> S[Pos - lp + i] then
        begin
          Inc(Pos);
          Break;
        end
        else if i = 1 then
        begin
         { tmp := Pos - lp;
          resaddr := start + tmp;      }
          
          Inc(Pos);
          break;
        end;
end;





procedure CMem_reader.search_for_chats();
var
  addr : DWord;
  Mbi: TMemoryBasicInformation;
  block_size, start, to_read,region_end : dword;
  buf : array of byte;
  pattern : string;
  mask : string;
  pattern_len : cardinal;
  my_pattern : array of byte;

begin
  //dout('started '+TimeToStr(Time));
 // pattern := '00 00 00 00 6F 6E 41 70 70 65 6E 64 43 68 61 74 28 71 75 69 6E 74 38 2C 51 53 74 72 69 6E 67';
//  mask := 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  pattern := '48 C5 1C 67 FF FF FF FF';
  mask := 'xxxxxxxx';
  pattern_len := length(mask);
  setLength(my_pattern, pattern_len);
  str_to_byte_array(pattern, my_pattern);

  Addr := 0;
  block_size := $100000;


  while VirtualQueryEx(hProc, Pointer(Addr), Mbi, SizeOf(Mbi)) <> 0 do
  begin
    if (Mbi.State = MEM_COMMIT) and not ((Mbi.Protect and PAGE_GUARD) = PAGE_GUARD) then
    begin
      //dlog('region: ' + IntToHex(Integer(Mbi.BaseAddress), 8) + ' size: ' + IntToHex(Mbi.RegionSize, 8));
      if (mbi.RegionSize < block_size) then begin
        buf := nil;
        setLength(buf, Mbi.RegionSize);
        readBytes(Cardinal(Mbi.BaseAddress), Mbi.RegionSize, buf);
        bin_BMSearch(0, buf, my_pattern, Cardinal(Mbi.BaseAddress));
      end else begin
        start := Cardinal(Mbi.BaseAddress);
        to_Read := block_size;
        region_end := Cardinal(Mbi.BaseAddress) + Cardinal(Mbi.RegionSize);

        while start<region_end do begin
          buf := nil;
          setLength(buf, to_Read);
          readBytes(start, to_Read, buf);
          bin_BMSearch(0, buf, my_pattern, start);
          start := start + to_read;
          if (start + to_read > region_end) then to_read := region_end - start;
        end;
      end;
    end;
    // Вычисляем адрес следуюшего региона
    Addr := Addr + Mbi.RegionSize;
  end;
  //dout('done at '+TimeToStr(time));
end;


procedure CMem_reader.test_pages();
var
  addr : DWord;
  Mbi: TMemoryBasicInformation;

begin

  Addr := 0;


  while VirtualQueryEx(hProc, Pointer(Addr), Mbi, SizeOf(Mbi)) <> 0 do
  begin
    if (Mbi.State = MEM_COMMIT) and not ((Mbi.Protect and PAGE_GUARD) = PAGE_GUARD) then
    begin
      log('base: ' + IntToHex(Integer(Mbi.BaseAddress), 8) + ' size: ' + IntToHex(Mbi.RegionSize, 8));

    end else begin
      //log('[BAD] base: ' + IntToHex(Integer(Mbi.BaseAddress), 8) + ' size: ' + IntToHex(Mbi.RegionSize, 8));
    end;

    // Вычисляем адрес следуюшего региона
    Addr := Addr + Mbi.RegionSize;
  end;
  //dout('done at '+TimeToStr(time));
end;

function EnableDebugPrivilege(pid : THandle; const Value: Boolean): Boolean;
const
  SE_DEBUG_NAME = 'SeDebugPrivilege';
var
  hToken: THandle;
  tp: TOKEN_PRIVILEGES;
  d: DWORD;
begin
  Result := False;
  if OpenProcessToken(pid, TOKEN_ADJUST_PRIVILEGES, hToken) then
  begin
    tp.PrivilegeCount := 1;
    LookupPrivilegeValue(nil, SE_DEBUG_NAME, tp.Privileges[0].Luid);
    if Value then
      tp.Privileges[0].Attributes := $00000002
    else
      tp.Privileges[0].Attributes := $80000000;
    AdjustTokenPrivileges(hToken, False, tp, SizeOf(TOKEN_PRIVILEGES), nil, d);
    if GetLastError = ERROR_SUCCESS then
    begin
      Result := True;
    end;
    CloseHandle(hToken);
  end;
end;



{
RACTORS
procedure TForm1.Button1Click(Sender: TObject);
  var RActorsAddress, RActorsMax,RActorsBits, RActorsBase : dword;
  ObjectManagerAddress : dword;
  pos, posmax : integer;
  bucket, nbBuckets : integer;
  bucketAddr, addr : dword;
  guid : dword;
  ttl : dword;
  name : string;

begin
  ObjectManagerAddress := $15799EC;

  RActorsAddress := mr.readUInt(ObjectManagerAddress);
  log('RActorsAddress = ' + shex(RActorsAddress));
  RActorsAddress := mr.readUInt(RActorsAddress + $8b0);
  log('RActorsAddress = ' + shex(RActorsAddress));
  RActorsMax := mr.readUInt(RActorsAddress + $100);
  log('RActorsMax = ' + shex(RActorsMax));
  RActorsBits := mr.readUInt(RActorsAddress + $18C);
  log('RActorsBits = ' + shex(RActorsBits));

  RActorsBase := mr.readUInt(RActorsAddress + $148);
  log('RActorsBase = ' + shex(RActorsBase));

  nbBuckets := round( RActorsMax / (1 shl RActorsBits) );
  log('nbBuckets = ' + sint(nbBuckets));
  ttl := 0;
  for bucket :=0 to nbBuckets - 1 do begin
    bucketAddr := mr.readUInt( RActorsBase + 4*bucket );
    if (bucketAddr = 0) then continue;
    log('   bucketAddr = ' + shex(bucketAddr));
    posmax := 1 shl RActorsBits;
    log('   posmax = ' + sint(posmax));

    for pos := 0 to posmax do begin
      addr := bucketAddr + $428 * pos;
      GUID := mr.readUInt(addr);
      name := mr.readASCIIString( addr + $8);
      if (GUID = $FFFFFFFF) or (GUID = 0) then continue;
      log('>> ' +shex(addr)+' => '+ name + '  [' + shex(guid) + ']');
      inc(ttl);
    end;
  end;

  log('total: ' + sint(ttl) );
end;

}
end.

