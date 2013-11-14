#include <string.h>
#include <algorithm>
#include "utf8.h"
#include "common.h"

using namespace std;

vector<wchar_t> preparePath(value src)
{
	int srcLen = val_strlen(src);
	
	std::vector<char> v8(srcLen);
	memcpy(&v8[0], val_string(src), srcLen);
	
	vector<wchar_t> v16; utf8::utf8to16(v8.begin(), v8.end(), back_inserter(v16));
	std::replace(v16.begin(), v16.end(), 0x2F, 0x5C);
	
	v16.push_back(0);
	
	return v16;
}
