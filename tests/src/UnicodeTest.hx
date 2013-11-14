package;

import neko.unicode.UnicodeStringTools;
import neko.unicode.File;

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
}
