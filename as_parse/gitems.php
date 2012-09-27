<?
require_once('mycurl.cls.php');
$c = new MyCurl();
$types = array('shield', 'helm', 'spirit-stone', 'voodoo-mask', 'wizard-hat', 'pauldrons', 'chest-armor', 'cloak', 'bracers', 'gloves', 'belt', 'mighty-belt', 'pants',
'boots', 'amulet', 'ring',  'quiver', 'mojo', 'orb', 'mace-1h', 'dagger', 'spear', 'sword-1h', 'axe-1h', 'mighty-weapon-1h', 'fist-weapon', 'ceremonial-knife',
'mace-2h', 'polearm', 'sword-2h', 'staff', 'axe-2h', 'daibo', 'mighty-weapon-2h', 'crossbow', 'bow', 'wand', 'hand-crossbow');

foreach ($types as $t) {
	echo $t."\r\n";
	
	$ru = $c->get('http://eu.battle.net/d3/ru/item/'.$t.'/');		$en = $c->get('http://eu.battle.net/d3/en/item/'.$t.'/');	file_put_contents('ru', $ru);	file_put_contents('en', $en);
	//$ru = file_get_contents('ru');	$en = file_get_contents('en');
	
	

	$items = array();
	preg_match_all('@<a href="/d3/ru/([^"]*?)"[^>]*?class="d3-color-(orange|green)">(.*?)</a>@', $ru, $m);
	foreach ($m[1]  as $k=>$name) 		$items[ $name ]['ru'] = str_replace('&#39;', "'", $m[3][ $k ]);

	preg_match_all('@<a href="/d3/en/([^"]*?)"[^>]*?class="d3-color-(orange|green)">(.*?)</a>@', $en, $m);
	foreach ($m[1]  as $k=>$name) 		$items[ $name ]['en'] = str_replace('&#39;', "'", $m[3][ $k ]);
	
	print_r($items);
	
	$fp = fopen('item.res', 'a');
	foreach ($items as $i) {
		if (!empty($i['ru']) && !empty($i['en']) ) fputs($fp, $i['en'].'|'.$i['ru']."\r\n");
	}
	fclose($fp);
	
	//break;
}
?>