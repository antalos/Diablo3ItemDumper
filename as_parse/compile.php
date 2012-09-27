<?
	$ss = file('item.res');
	foreach ($ss as $s) {
		$s = trim($s);
		if ($s == '') continue;
		list($en, $ru) = explode('|', $s);
		 //$ru = mb_convert_encoding ( $ru , 'cp1251');
		
		//echo "s := srep(s, '«".str_replace("'", "''", $ru)."»', '«".str_replace("'", "''", $en)."»');	\r\n";
		echo "s := srep(s, '".str_replace("'", "''", $ru)."', '".str_replace("'", "''", $en)."');	\r\n";
	}
?>