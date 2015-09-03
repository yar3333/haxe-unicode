import unicode.UnicodeStringTools;
import unicode.File;
import unicode.FileSystem;
using StringTools;

class UnicodeTest extends haxe.unit.TestCase
{
    public function testOemToUtf8()
    {
		var oem = "s" + String.fromCharCode(255) + "w";
		var utf8 = UnicodeStringTools.oemToUtf8(oem);
		assertEquals("sяw", utf8);
    }
    
	public function testUtf8ToOem()
    {
		var utf8 = "sяw";
		var oem = UnicodeStringTools.utf8ToOem(utf8);
		assertEquals("s" + String.fromCharCode(255) + "w", oem);
    }
	
	public function testFile()
    {
		var src = "test-овая строка";
		File.saveContent("ыяч.txt", src);
		var dst = File.getContent("ыяч.txt");
		assertEquals(dst, src);
    }
	
	public function testReadDir()
    {
		var files = FileSystem.readDirectory(".");
		print("\nFILES = \n\t" + files.join("\n\t") + "\n");
		assertTrue(true);
    }
	
	public function testIsDirectory()
    {
		assertTrue(FileSystem.isDirectory("dir"));
		assertTrue(FileSystem.isDirectory("папка"));
		assertTrue(!FileSystem.isDirectory("файл.txt"));
		assertTrue(!FileSystem.isDirectory("file.txt"));
    }
	
	public function testRename()
    {
		var src = "файл.txt";
		var dest = "другое имя.txt";
		
		FileSystem.rename(src, dest);
		assertTrue(!FileSystem.exists(src));
		assertTrue(FileSystem.exists(dest));
		
		FileSystem.rename(dest, src);
		assertTrue(!FileSystem.exists(dest));
		assertTrue(FileSystem.exists(src));
    }
	
	public function testStatA(path:String) stat("file.txt");
	public function testStatB(path:String) stat("файл.txt");
	
	function stat(path:String)
    {
		var stat = FileSystem.stat(path);
		
		assertEquals(3, stat.size);
		
		assertTrue(Std.is(stat.atime, Date));
		assertTrue(stat.atime.getTime() != 0);
		
		assertTrue(Std.is(stat.ctime, Date));
		assertTrue(stat.ctime.getTime() != 0);
		
		assertTrue(Std.is(stat.mtime, Date));
		assertTrue(stat.mtime.getTime() != 0);
	}
	
	public function testFullPath()
    {
		var r = FileSystem.fullPath("файл.txt");
		
		assertTrue(r != null);
		assertTrue(r != "");
		assertTrue(r.endsWith("\\файл.txt") || r.endsWith("//файл.txt") );
    }
}
