unit d3ui;

interface
uses windows, d3const, mem_reader, sysutils, functions, translator;

function get_ui_baseaddr( uitype : int64) : dword;
function is_ui_visible(uitype : int64) : boolean;
function get_text_value( uitype : int64) : string;
function get_text_value2( uitype : int64) : string;
function get_ui_dumpstr( addr :dword) : string;

procedure update_mr();
procedure dump_ui();

function get_info_from_itempopup() : string;
function  get_full_charinfo() : string;
function  get_short_charinfo() : string;

implementation
uses unit1;


procedure update_mr();
var wd : hwnd;
begin

  try
   if assigned(mr) then mr.Free;
  finally
  end;
    mr := CMem_reader.create(  );
    mr.attach( getforegroundwindow() );
end;

procedure dump_ui();
 var RActorsAddress, RActorsMax,RActorsBits, RActorsBase : dword;
  ObjectManagerAddress : dword;
  posmax : integer;
  bucket, nbBuckets : integer;
  bucketAddr, addr : dword;
  guid : dword;
  ttl : dword;
  s, name : string;

  i, nitems : dword;
  id, id2, id3, id4 : dword;

  v1, test, j : dword;
  f : textfile;
  a : int64;

begin
//Root.TopLayer.item 2.stack.top_wrapper.stack.name [8B53294A, 74E93828]
//Root.TopLayer.item 2.stack.top_wrapper.stack.name [8424326324760553802]

// a2 = A shl 32
 { a := 8424326324760553802;

  i := a shl 32; //8B53294A
  j := a shr 32; //74E93828
  log( shex(  i  ) );
  log( shex(  j  ) );
//  log( shex(  A shl 32 ) );

  exit;    }

  update_mr();

  ObjectManagerAddress := offObjectMngr;

  RActorsAddress := mr.readUInt(ObjectManagerAddress);
  RActorsAddress := mr.readUInt(RActorsAddress + offObjectMngr_uilist);
  RActorsAddress := mr.readUInt(RActorsAddress);

  RActorsAddress := mr.readUInt(RActorsAddress + 8);
  log('RActorsAddress = ' + shex(RActorsAddress));

  nitems := mr.readUInt(ObjectManagerAddress);
  nitems := mr.readUInt(nitems + offObjectMngr_uilist);
  nitems := mr.readUInt(nitems);
  nitems := mr.readUInt(nitems + $40);
  log('nitems = ' + sint(nitems));

  assignfile(f, 'ui_dump.txt');
  rewrite(f);

  j := 0;
  for i := 0 to nitems  do begin
     addr := mr.readUInt(RActorsAddress + i*4);
     if addr = 0  then continue;

     s := get_ui_dumpstr(addr); if s <> '' then writeln(f,  s);

      addr := read(addr);
      while (addr > 0)  and (addr < $FFFFFFFF) do begin
        s := get_ui_dumpstr(addr); if s <> '' then writeln(f,  s);
        inc(j);
        addr := read(addr);
      end;
      inc(j);
  end;
  log('done, got: '+inttostr(j));
  closefile(f);
end;

function get_ui_baseaddr( uitype : int64) : dword;
var var1, ObjectID : dword;
  test, UI_PointerBase, UI_Offset1 : dword;

  index : integer;
  ui_base, a1, addr, lastAddr : dword;
  v1, xored, reada1, reada12 : dword;
begin
  //!!! reversed from __cdecl sub_93E070 1.0.2
  reada1 := uitype shl 32; //8B53294A
  reada12 := uitype shr 32; //74E93828
//  reada1 := hashrec[ uitype ].hash1;
//  reada12 := hashrec[ uitype ].hash2;

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



function is_ui_visible(uitype : int64) : boolean;
  var base, res : dword;
begin
  result := false;
  base := get_ui_baseaddr(uitype);
  if base = 0 then exit;

  res := read(base + off_isVisible);
  if res <> 0 then result := true;
end;


function get_text_value( uitype : int64) : string;
  var addr : dword;
begin
  //found addr of value with cheatengine, look for offset from base manually
  result := '';
  addr := get_ui_baseaddr( uitype );
  if addr = 0 then exit;
//  log('reading from ' + shex( read(addr + off_text_value)) );
  result := mr.readLongString( read(addr + off_text_value) );
end;

function get_text_value2( uitype : int64) : string;
  var s,s2 : string;
  i : integer;
  intag : boolean;

begin
  s := get_text_value(uitype);
  s2 := '';

  if pos('{', s) > 0 then begin
    intag := false;
    for i := 1 to length(s) do begin
      if s[i] = '{' then intag := true
        else if s[i] = '}' then intag := false
        else if not(intag) then s2 := s2 + s[i];

    end;
  end else begin
    s2 := s;
  end;
  s2 := StringReplace(s2, chr(10), chr(13)+chr(10), [rfReplaceAll]);
  s2 := trim(s2);


  result := s2;
end;


function get_ui_dumpstr( addr :dword) : string;
var id3, id4 : dword;
  s, name : string;
  id : Int64;
begin
//  id3 := read( addr + 8);
//  id4 := read( addr + $c);
//  id := mr.readLong( addr + $c );
  id := mr.readLong( addr + $8 );
  name := mr.readLongString( addr + 16);

{  hashrec[ 1024 ].hash1 := id3;
  hashrec[ 1024 ].hash2 := id4;
  s := get_text_value( 1024 ); }

  s := get_text_value( id );


//  result := shex(addr) + ' => ' + name + ' [' + shex(id3) + ', ' + shex(id4) +']';
  result := shex(addr) + ' => ' + name + ' [' + inttostr(id) +']';
  if length(s) > 0 then result := result + #13#10 + ' >>> '+s;

//  if is_ui_visible(id) = false then result := '';

end;







function get_info_from_itempopup() : string;
  var s,s2,q, s3 : string;
    dotr : boolean;
begin
  update_mr();

  if not(is_ui_visible(ITEM_POPUP_NAME)) then begin
    result := '!nopopup!';
    exit;
  end;

  if form1.cbTranslate.checked then dotr := true
    else dotr := false;


  s := get_text_value2( ITEM_POPUP_NAME );
  s3 := get_text_value2( ITEM_POPUP_TYPE );
  if (dotr) then begin
   s := translate_title(s);
   s3 := translate_type(s3);
  end;
  s := s + #13#10 + s3;

  if is_ui_visible(ITEM_POPUP_SLOT) then begin
    s3 :=  get_text_value2( ITEM_POPUP_SLOT );
    if (dotr) then s3 := translate_slot(s3);
    s := s + ' | ' + s3;
  end;


  if is_ui_visible(ITEM_POPUP_REQS) then begin
    q := get_text_value2( ITEM_POPUP_REQS );
    q := StringReplace(q, 'Required Level:', 'lvlreq:', [rfReplaceAll]);
    q := StringReplace(q, 'Требуемый уровень:', 'lvlreq:', [rfReplaceAll]);
    q := StringReplace(q, 'Уникальный предмет', 'Unique Equipped - ', [rfReplaceAll]);
    q := StringReplace(q, 'Требуется лук', 'Ranged wep required - ', [rfReplaceAll]);


    q := StringReplace(q, #13, '', [rfReplaceAll]);
    q := StringReplace(q, #10, ' ', [rfReplaceAll]);
    s := s + ' | ' + q;
  end;

  if is_ui_visible(ITEM_POPUP_ILVL) then begin
    q := get_text_value2( ITEM_POPUP_ILVL );
    q := StringReplace(q, 'Уровень предмета', 'iLvl', [rfReplaceAll]);
    q := StringReplace(q, 'Item Level', 'iLvl', [rfReplaceAll, rfIgnoreCase]);
    s := s + ' | '+q;
  end;

  if is_ui_visible(ITEM_POPUP_SALEVALUE) then begin
    q := trim( get_text_value2( ITEM_POPUP_SALEVALUE ) );
    q := StringReplace(q, 'Цена продажи:', 'gold: ', [rfReplaceAll]);
    q := StringReplace(q, 'Sell Value:', 'gold: ', [rfReplaceAll]);
    q := StringReplace(q, '  ', ' ', [rfReplaceAll]);
    s := s + #13#10 + q;
  end;


  if is_ui_visible(ITEM_POPUP_RATING) then begin
    s := s + #13#10 ;
    q := get_text_value2( ITEM_POPUP_RATING_NAME );
    q := StringReplace(q, 'Damage Per Second', 'DPS', [rfReplaceAll]);
    q := StringReplace(q, 'ед. урона в секунду', 'DPS', [rfReplaceAll]);
    if (dotr) then q := StringReplace(q, 'Броня', 'Armor', [rfReplaceAll]);
    s := s + q +': ';
    s := s + get_text_value2( ITEM_POPUP_RATING );
  end;



  if is_ui_visible(ITEM_POPUP_SPEC_STATS) then begin
    s2 := get_text_value2( ITEM_POPUP_SPEC_STATS );

    if (dotr) then begin
      s2 := StringReplace(s2, 'ед. урона', 'Damage', [rfReplaceAll, rfIgnoreCase]);
      s2 := StringReplace(s2, 'атак в сек.', 'Attacks per Second', [rfReplaceAll, rfIgnoreCase]);
      s2 := StringReplace(s2, 'вероятность блокировать удар', 'Chance to Block', [rfReplaceAll, rfIgnoreCase]);
      s2 := StringReplace(s2, 'блока', 'Block Amount', [rfReplaceAll, rfIgnoreCase]);

    end;
    if s2 <> '' then s := s + #13#10 + s2;
  end;

  if is_ui_visible(ITEM_POPUP_STATS) then s := s + #13#10 + get_stats_value( ITEM_POPUP_STATS, dotr );
  if is_ui_visible(ITEM_POPUP_SOCKET1) then s := s + #13#10 +'[socket]: '+ get_stats_value( ITEM_POPUP_SOCKET1, dotr );
  if is_ui_visible(ITEM_POPUP_SOCKET2) then s := s + #13#10 +'[socket]: '+ get_stats_value( ITEM_POPUP_SOCKET2, dotr );
  if is_ui_visible(ITEM_POPUP_SOCKET3) then s := s + #13#10 +'[socket]: '+ get_stats_value( ITEM_POPUP_SOCKET3, dotr );

//  s := s + #13#10 + get_text_value( ITEM_POPUP_REQS ) + ' - ' + get_text_value( ITEM_POPUP_COST ) + ' - ' +get_text_value( ITEM_POPUP_DURABILITY) ;
  result := s;

end;

function  get_short_charinfo() : string;
var s : string;
begin
  update_mr();
  s := 'Lvl: '+get_text_value2(CHAR_LVL)+ #13#10;

  s := s + 'Str: '+get_text_value2(CHAR_STR)+ #13#10;
  s := s + 'Dex: '+get_text_value2(CHAR_DEX)+ #13#10;
  s := s + 'Int: '+get_text_value2(CHAR_INT)+ #13#10;
  s := s + 'Vit: '+get_text_value2(CHAR_VIT)+ #13#10;
  s := s + 'Armor: '+get_text_value2(CHAR_ARMOR)+ #13#10;
  s := s + 'DPS: '+get_text_value2(CHAR_DPS);
  result := s;
end;


function  get_full_charinfo() : string;
var s : string;
begin
  update_mr();
  s := get_short_charinfo()+ #13#10;
  s := s + '------------------' + #13#10;
  s := s + 'DMG from stat: '+get_text_value2(CHAR_DMG_STAT)+ #13#10;
  s := s + 'DMG from skills: '+get_text_value2(CHAR_DMG_SKILL)+ #13#10;
  s := s + 'Attacks per sec: '+get_text_value2(CHAR_DMG_ATTACK_PERSEC)+ #13#10;
  s := s + 'Crit chance: '+get_text_value2(CHAR_DMG_CRITHIT)+ #13#10;
  s := s + 'Crit dmg: '+get_text_value2(CHAR_DMG_CRITDMG)+ #13#10;
  s := s + '------------------'+ #13#10;

  s := s + 'Block amount: '+get_text_value2(CHAR_BLOCK_AMNT)+ #13#10;
  s := s + 'Block chance: '+get_text_value2(CHAR_BLOCK)+ #13#10;
  s := s + 'Dodge: '+get_text_value2(CHAR_DODGE)+ #13#10;
  s := s + 'Dmg reduction: '+get_text_value2(CHAR_DMG_REDUCE)+ #13#10;

  s := s + 'Phys res: '+get_text_value2(CHAR_RES_PHYS)+ #13#10;
  s := s + 'Cold res: '+get_text_value2(CHAR_RES_COLD)+ #13#10;
  s := s + 'Fire res: '+get_text_value2(CHAR_RES_FIRE)+ #13#10;
  s := s + 'Light res: '+get_text_value2(CHAR_RES_LIGHTNING)+ #13#10;
  s := s + 'Poison res: '+get_text_value2(CHAR_RES_POISON)+ #13#10;
  s := s + 'Arcane res: '+get_text_value2(CHAR_RES_ARCANE)+ #13#10;

  s := s + 'СС reduction: '+get_text_value2(CHAR_CC_REDUCE)+ #13#10;
  s := s + 'Missile dmg reduction: '+get_text_value2(CHAR_MISSILE_DEF)+ #13#10;
  s := s + 'Meelee dmg reduction: '+get_text_value2(CHAR_MELEE_DEF)+ #13#10;
  s := s + 'Thorns: '+get_text_value2(CHAR_THORNS)+ #13#10;

  s := s + '------------------'+ #13#10;
  s := s + 'Life: '+get_text_value2(CHAR_LIFE)+ #13#10;
  s := s + 'Life bonus: '+get_text_value2(CHAR_LIFE_BONUS)+ #13#10;
  s := s + 'Life per sec: '+get_text_value2(CHAR_LIFE_PERSEC)+ #13#10;
  s := s + 'Life steal: '+get_text_value2(CHAR_LIFE_STEAL)+ #13#10;
  s := s + 'Life per kill: '+get_text_value2(CHAR_LIFE_PERKILL)+ #13#10;
  s := s + 'Life per hit: '+get_text_value2(CHAR_LIFE_PERHIT)+ #13#10;
  s := s + 'Life globes bonus: '+get_text_value2(CHAR_LIFE_GLOBEBONUS)+ #13#10;
  s := s + 'Pickup radius: '+get_text_value2(CHAR_PICKUP)+ #13#10;
  s := s + '------------------'+ #13#10;

 { s := s + get_text_value2(RES1_NAME)+ ': ' +  get_text_value2(RES1_VAL) + #13#10;
  s := s + get_text_value2(RES2_NAME)+ ': ' +  get_text_value2(RES2_VAL) + #13#10;
  s := s + '------------------'+ #13#10;         }

  s := s + 'Move speed: '+get_text_value2(CHAR_MOVESPEED)+ #13#10;
  s := s + 'Gold find: '+get_text_value2(CHAR_GF)+ #13#10;
  s := s + 'Magic find: '+get_text_value2(CHAR_MF)+ #13#10;
  s := s + 'Bonus XP: '+get_text_value2(CHAR_BONUSXP)+ #13#10;
  s := s + 'Bonus XP per kill: '+get_text_value2(CHAR_BONUSXP_PERKILL)+ #13#10;


  s := s + '-----[ Build ]-------------'+ #13#10;
  s := s + 'LClick: '+get_text_value2(SKILL_LEFT)+' - '+get_text_value2(SKILL_LEFT_RUNE)+ #13#10;
  s := s + 'RClick: '+get_text_value2(SKILL_RIGHT)+' - '+get_text_value2(SKILL_RIGHT_RUNE)+ #13#10;

  s := s + 'Skill 1: '+get_text_value2(SKILL1)+' - '+get_text_value2(SKILL1_RUNE)+ #13#10;
  s := s + 'Skill 2: '+get_text_value2(SKILL2)+' - '+get_text_value2(SKILL2_RUNE)+ #13#10;
  s := s + 'Skill 3: '+get_text_value2(SKILL3)+' - '+get_text_value2(SKILL3_RUNE)+ #13#10;
  s := s + 'Skill 4: '+get_text_value2(SKILL4)+' - '+get_text_value2(SKILL4_RUNE);



  result := s;
end;


end.
