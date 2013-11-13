package ;

class Main
{
    static function main()
	{
		var r = new haxe.unit.TestRunner();
		r.add(new UnicodeTest());
		r.run();
	}
}
