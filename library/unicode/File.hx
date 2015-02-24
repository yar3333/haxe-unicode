package unicode;

import neko.Lib;

class File
{
	public static var getContent(default, null) : String->String;
	public static var saveContent(default, null) : String->String->Void;
	
	static function __init__()
	{
		if (Sys.systemName() == "Windows")
		{
			getContent = function(filePath) return Lib.nekoToHaxe(file_get_content(Lib.haxeToNeko(filePath)));
			saveContent = function(filePath, content) file_save_content(Lib.haxeToNeko(filePath), Lib.haxeToNeko(content));
		}
		else
		{
			getContent = sys.io.File.getContent;
			saveContent = sys.io.File.saveContent;
		}
	}
	
	static var file_get_content = Lib.loadLazy("unicode","file_get_content", 1);
	static var file_save_content = Lib.loadLazy("unicode","file_save_content", 2);
}