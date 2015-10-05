package unicode;

import neko.Lib;
import sys.FileStat;
using StringTools;

class FileSystem
{
	public static dynamic function createDirectory(path:String) : Void {}
	public static dynamic function exists(path:String) : Bool return null;
	public static dynamic function readDirectory(path:String) : Array<String> return null;
	public static dynamic function isDirectory(path:String) : Bool return null;
	public static dynamic function rename(src:String, dest:String) : Void {}
	public static dynamic function fullPath(path:String) : String return null;
	public static dynamic function stat(path:String) : FileStat return null;
	public static dynamic function deleteFile(path:String) : Void {}
	public static dynamic function deleteDirectory(path:String) : Void {}
	
	static function __init__()
	{
		if (Sys.systemName() == "Windows")
		{
			createDirectory = function(path)
			{
				path = path.replace("\\", "/");
				var parts = path.split("/");
				if (parts.length > 1) createDirectory(parts.slice(0, parts.length - 1).join("/"));
				if (!exists(path)) filesystem_create_directory(Lib.haxeToNeko(path));
			};
			
			exists = function(path) return filesystem_exists(Lib.haxeToNeko(path));
			readDirectory = function(path) return Lib.nekoToHaxe(filesystem_read_directory(Lib.haxeToNeko(path)));
			isDirectory = function(path) return filesystem_is_directory(Lib.haxeToNeko(path));
			rename = function(src, dest) filesystem_rename(Lib.haxeToNeko(src), Lib.haxeToNeko(dest));
			fullPath = function(path) return Lib.nekoToHaxe(filesystem_full_path(Lib.haxeToNeko(path)));
			stat = function(path)
			{
				var r : FileStat = Lib.nekoToHaxe(filesystem_stat(Lib.haxeToNeko(path)));
				r.atime = Date.fromTime(cast r.atime);
				r.mtime = Date.fromTime(cast r.mtime);
				r.ctime = Date.fromTime(cast r.ctime);
				return r;
			};
			deleteFile = function(path) filesystem_remove(Lib.haxeToNeko(path));
			deleteDirectory = function(path) filesystem_remove(Lib.haxeToNeko(path));
		}
		else
		{
			createDirectory = sys.FileSystem.createDirectory;
			exists = sys.FileSystem.exists;
			readDirectory = sys.FileSystem.readDirectory;
			isDirectory = sys.FileSystem.isDirectory;
			rename = sys.FileSystem.rename;
			fullPath = sys.FileSystem.fullPath;
			stat = sys.FileSystem.stat;
			deleteFile = sys.FileSystem.deleteFile;
			deleteDirectory = sys.FileSystem.deleteDirectory;
		}
	}
	
	static var filesystem_create_directory = Lib.loadLazy("unicode", "filesystem_create_directory", 1);
	static var filesystem_exists = Lib.loadLazy("unicode", "filesystem_exists", 1);
	static var filesystem_read_directory = Lib.loadLazy("unicode", "filesystem_read_directory", 1);
	static var filesystem_is_directory = Lib.loadLazy("unicode", "filesystem_is_directory", 1);
	static var filesystem_rename = Lib.loadLazy("unicode", "filesystem_rename", 2);
	static var filesystem_full_path = Lib.loadLazy("unicode", "filesystem_full_path", 1);
	static var filesystem_stat = Lib.loadLazy("unicode", "filesystem_stat", 1);
	static var filesystem_remove = Lib.loadLazy("unicode", "filesystem_remove", 1);
}