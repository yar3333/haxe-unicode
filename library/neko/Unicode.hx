package neko;

import neko.Lib;

class Unicode
{
	public static function oemToUtf8(s:String) : String return Lib.nekoToHaxe(oem_to_utf8(Lib.haxeToNeko(s)));
	public static function utf8ToOem(s:String) : String return Lib.nekoToHaxe(utf8_to_oem(Lib.haxeToNeko(s)));
	
	static var oem_to_utf8 = Lib.load("unicode","oem_to_utf8", 1);
	static var utf8_to_oem = Lib.load("unicode","utf8_to_oem", 1);
}