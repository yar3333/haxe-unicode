#if _WINDOWS

#include <cstring>
#include <stdio.h>
#include <algorithm>
#include "utf8.h"
#include "common.h"

using namespace std;

value file_get_content(value filePath)
{	
	vector<wchar_t> filePath16 = preparePath(filePath);
	FILE *f = _wfopen(&filePath16[0], L"rb");
	if (!f)
	{
		vector<wchar_t> filePath8; utf8::utf16to8(filePath16.begin(), filePath16.end(), back_inserter(filePath8));
		filePath8.push_back(0);
		char buf[65536]; sprintf(buf, "Can't open file '%s' for reading.", &filePath8[0]);
		failure(buf);
	}
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
	FILE *f = _wfopen(&preparePath(filePath).front(), L"wb");
	if (!f)
	{
		char buf[65536]; sprintf(buf, "Can't open file '%s' for writing.", val_string(filePath));
		failure(buf);
	}
	fputs(val_string(content), f);
	fclose(f);
	return val_true;
}
DEFINE_PRIM(file_save_content, 2);

#endif