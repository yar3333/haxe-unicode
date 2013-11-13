package;

import neko.Unicode;

class UnicodeTest extends haxe.unit.TestCase
{
    public function testOemToUtf8()
    {
		var oem = "s" + String.fromCharCode(255) + "w";
		var utf8 = Unicode.oemToUtf8(oem);
		assertEquals("sяw", utf8);
    }
    
	public function testUtf8ToOem()
    {
		var utf8 = "sяw";
		var oem = Unicode.utf8ToOem(utf8);
		assertEquals("s" + String.fromCharCode(255) + "w", oem);
    }
}
