include Makefile.platform
include Makefile.ndll

PROJECT=unicode

CCFLAGS+=-I pcre
LDFLAGS+=pcre/.libs/libpcre.a 

pcre: FORCE
	cd pcre && ./configure --enable-utf --enable-unicode-properties --with-pcregrep-bufsize=20480 && make

FORCE: