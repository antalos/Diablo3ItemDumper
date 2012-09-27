
function is_ui_visible_old(uitype : dword) : boolean;
  var base, res : dword;
begin
  result := false;
  base := get_ui_baseaddr(base);
  if base = 0 then exit;

  res := read(base + off_isVisible);
  if res <> 0 then result := true;
end;


function get_text_value_old( uitype : dword) : string;
  var addr : dword;
begin
  //found addr of value with cheatengine, look for offset from base manually
  result := '';
  addr := get_ui_baseaddr( uitype );
  if addr = 0 then exit;
//  log('reading from ' + shex( read(addr + off_text_value)) );
  result := mr.readLongString( read(addr + off_text_value) );
end;


function get_ui_baseaddr2( uitype : dword) : dword;
var var1, ObjectID : dword;
  test, UI_PointerBase, UI_Offset1 : dword;

  index : integer;
  ui_base, a1, addr, lastAddr : dword;
  v1, xored, reada1, reada12 : dword;
begin
  //!!! reversed from __cdecl sub_93E070 1.0.2
  reada1 := hashrec[ uitype ].hash1;
  reada12 := hashrec[ uitype ].hash2;

  //log('addr = ' + shex(a1) +' => '+ shex( reada1 ) +'   +4 => '+shex( reada12 ) );
  ui_base := read(read(read( offObjectMngr ) + offObjectMngr_uilist));
  //log('uibase = ' + shex(ui_base));

  xored := reada1 xor reada12;
  //log('xored = ' + Shex(xored) );
  test := read( ui_base + $40 );
  //log('test = ' + Shex(test) );
  test := test and xored;
  //log('test = ' + Shex(test) );


  v1 := read(read(ui_base + 8)  + 4 * (read( ui_base + $40 ) and xored));
  //log('v1 = ' + shex(v1));
  result := 0;
  if (v1 > 0) then begin
    while (read(v1 + 8) <> reada1) or (read(v1 + $c) <> reada12 ) do begin
      //log('iter, v1 = ' + shex(v1) );
      v1 := read(v1);
      if ( v1 = 0  ) then begin
        //log('erra while looping');
        result := 0;
        exit;
      end;
    end;

//    log('finished, res = ' + shex(v1) );
    result := read(v1 + offUIItemProperties);
//    log('   res = ' + shex(result) );
//    log('   value = ' + shex( read(result + $0CFC) ) );

  end else begin
    //log('ERRA');
    result := 0;
  end;

end;