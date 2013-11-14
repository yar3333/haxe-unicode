package neko.unicode;

import neko.Lib;

class File
{
	static var get_content : String->String;
	static var save_content : String->String->Void;
	
	static function __init__()
	{
		if (Sys.systemName() == "Windows")
		{
			get_content = function(filePath) return Lib.nekoToHaxe(file_get_content(Lib.haxeToNeko(filePath)));
			save_content = function(filePath, content) file_save_content(Lib.haxeToNeko(filePath), Lib.haxeToNeko(content));
		}
		else
		{
			get_content = sys.io.File.getContent;
			save_content = sys.io.File.saveContent;
		}
	}
	
	public static inline function getContent(filePath:String) : String
	{
		return get_content(filePath);
	}
	
	public static inline function saveContent(filePath:String, content:String) : Void
	{
		save_content(filePath, content);
	}
	
	static var file_get_content = Lib.loadLazy("unicode","file_get_content", 1);
	static var file_save_content = Lib.loadLazy("unicode","file_save_content", 2);
}