#include <stdlib.h>
#include <string>
#include <vector>
#include <clocale>
#include <cstring>
#include "utf8.h"
#include <neko.h>

using namespace std;

value string_oem_to_utf8(value src)
{	
	setlocale(LC_ALL, "");
	
	int srcLen = val_strlen(src);
	
	wchar_t p16[srcLen + 1];
	int charWrittenCount = mbstowcs(p16, val_string(src), srcLen);
	
	std::vector<wchar_t> v16(charWrittenCount);
	memcpy(&v16[0], p16, charWrittenCount * sizeof(wchar_t));
	string u8; utf8::utf16to8(v16.begin(), v16.end(), back_inserter(u8));
	
	value r = alloc_string(u8.c_str());
	return r;
}
DEFINE_PRIM(string_oem_to_utf8, 1);

value string_utf8_to_oem(value src)
{	
	setlocale(LC_ALL, "");
	
	int srcLen = val_strlen(src);
	
	std::vector<char> v8(srcLen);
	memcpy(&v8[0], val_string(src), srcLen);
	
	vector<wchar_t> v16; utf8::utf8to16(v8.begin(), v8.end(), back_inserter(v16));
	
	char p8[srcLen + 1];
	int dstLen = wcstombs(p8, &v16[0], v16.size());
	p8[dstLen] = '\0';
	
	value r = alloc_string(p8);
	return r;
}
DEFINE_PRIM(string_utf8_to_oem, 1);
