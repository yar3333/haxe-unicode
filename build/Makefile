default: pcre build

include Makefile.platform
include Makefile.ndll

PROJECT=unicode

CCFLAGS+=-I pcre
LDFLAGS+=pcre/.libs/libpcre.a

ifeq ($(PLATFORM), Linux64)
	PCRE_CCFLAGS := CFLAGS="-fPIC"
endif

pcre: pcre/.libs/libpcre.a

pcre/.libs/libpcre.a:
	cd pcre && ./configure --enable-utf --enable-unicode-properties --with-pcregrep-bufsize=20480 $(PCRE_CCFLAGS) && make

all: clean default

.PHONY: default pcre
