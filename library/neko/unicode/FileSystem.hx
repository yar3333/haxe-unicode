package neko.unicode;

import neko.Lib;

class FileSystem
{
	public static var exists(default, null) : String->Bool;
	public static var readDirectory(default, null) : String->Array<String>;
	public static var isDirectory(default, null) : String->Bool;
	
	static function __init__()
	{
		if (Sys.systemName() == "Windows")
		{
			exists = function(path) return filesystem_exists(Lib.haxeToNeko(path));
			readDirectory = function(path) return Lib.nekoToHaxe(filesystem_read_directory(Lib.haxeToNeko(path)));
			isDirectory = function(path) return filesystem_is_directory(Lib.haxeToNeko(path));
		}
		else
		{
			exists = sys.FileSystem.exists;
			readDirectory = sys.FileSystem.readDirectory;
		}
	}
	
	static var filesystem_exists = Lib.loadLazy("unicode", "filesystem_exists", 1);
	static var filesystem_read_directory = Lib.loadLazy("unicode", "filesystem_read_directory", 1);
	static var filesystem_is_directory = Lib.loadLazy("unicode", "filesystem_is_directory", 1);
}