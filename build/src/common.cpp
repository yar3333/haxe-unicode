#include <string.h>
#include <algorithm>
#include "utf8.h"
#include "common.h"

using namespace std;

vector<wchar_t> preparePathIn(value src)
{
	int srcLen = val_strlen(src);
	
	vector<char> v8(srcLen);
	memcpy(&v8[0], val_string(src), srcLen);
	
	vector<wchar_t> v16; utf8::utf8to16(v8.begin(), v8.end(), back_inserter(v16));
	replace(v16.begin(), v16.end(), 0x2F, 0x5C);
	
	v16.push_back(0);
	
	return v16;
}

value preparePathOut(const wchar_t *src)
{
	int srcLen = wcslen(src);
	
	vector<wchar_t> r16(srcLen);
	memcpy(&r16[0], src, srcLen * sizeof(src[0]));
	r16.push_back(0);
	
	vector<char> r8; utf8::utf16to8(r16.begin(), r16.end(), back_inserter(r8));
	return alloc_string(&r8[0]);
}
