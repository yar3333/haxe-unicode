package unicode;

import neko.Lib;

class File
{
	public static dynamic function getContent(filePath:String) : String return null;
	public static dynamic function saveContent(filePath:String, content:String) : Void {}
	public static dynamic function copy(srcFilePath:String, destFilePath:String) : Void {}
	
	static function __init__()
	{
		if (Sys.systemName() == "Windows")
		{
			getContent = function(filePath) return Lib.nekoToHaxe(file_get_content(Lib.haxeToNeko(filePath)));
			saveContent = function(filePath, content) file_save_content(Lib.haxeToNeko(filePath), Lib.haxeToNeko(content));
			copy = function(src, dest) file_copy(Lib.haxeToNeko(src), Lib.haxeToNeko(dest));
		}
		else
		{
			getContent = sys.io.File.getContent;
			saveContent = sys.io.File.saveContent;
			copy = sys.io.File.copy;
		}
	}
	
	static var file_get_content = Lib.loadLazy("unicode","file_get_content", 1);
	static var file_save_content = Lib.loadLazy("unicode","file_save_content", 2);
	static var file_copy = Lib.loadLazy("unicode","file_copy", 2);
}