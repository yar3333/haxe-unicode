package neko.unicode;

import neko.Lib;

class UnicodeStringTools
{
	public static function oemToUtf8(s:String) : String return Lib.nekoToHaxe(string_oem_to_utf8(Lib.haxeToNeko(s)));
	public static function utf8ToOem(s:String) : String return Lib.nekoToHaxe(string_utf8_to_oem(Lib.haxeToNeko(s)));
	
	static var string_oem_to_utf8 = Lib.load("unicode","string_oem_to_utf8", 1);
	static var string_utf8_to_oem = Lib.load("unicode","string_utf8_to_oem", 1);
}