#include <vector>
#include <cstring>
#include <stdio.h>
#include "utf8.h"
#include <neko.h>

using namespace std;

vector<wchar_t> valueUtf8ToVector16(value src)
{
	int srcLen = val_strlen(src);
	
	std::vector<char> v8(srcLen);
	memcpy(&v8[0], val_string(src), srcLen);
	
	vector<wchar_t> v16; utf8::utf8to16(v8.begin(), v8.end(), back_inserter(v16));
	return v16;
}

value file_get_content(value filePath)
{	
	FILE *f = _wfopen(&valueUtf8ToVector16(filePath).front(), L"rb");
	fseek(f, 0, SEEK_END);
	size_t size = ftell(f);
	char *buf = new char[size + 1];
	rewind(f);
	fread(buf, sizeof(char), size, f);
	fclose(f);
	buf[size] = '\0';
	value r = alloc_string(buf);
	delete[] buf;	
	return r;
}
DEFINE_PRIM(file_get_content, 1);

value file_save_content(value filePath, value content)
{	
	FILE *f = _wfopen(&valueUtf8ToVector16(filePath).front(), L"wb");
	fputs(val_string(content), f);
	fclose(f);
	return val_true;
}
DEFINE_PRIM(file_save_content, 2);
