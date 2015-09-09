#if _WINDOWS

#include <cstring>
#include <stdio.h>
#include <algorithm>
#include "utf8.h"
#include "common.h"

using namespace std;

value file_get_content(value filePath)
{	
	vector<wchar_t> filePath16 = preparePathIn(filePath);
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
	FILE *f = _wfopen(&preparePathIn(filePath).front(), L"wb");
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

value file_copy(value srcFilePath, value destFilePath)
{	
	FILE *finp = _wfopen(&preparePathIn(srcFilePath).front(), L"rb");
	if (!finp)
	{
		char buf[65536]; sprintf(buf, "Can't open file '%s' for reading.", val_string(srcFilePath));
		failure(buf);
	}
	
	FILE *fout = _wfopen(&preparePathIn(destFilePath).front(), L"wb");
	if (!fout)
	{
		char buf[65536]; sprintf(buf, "Can't open file '%s' for writing.", val_string(destFilePath));
		failure(buf);
	}
	
	char buf[BUFSIZ];
    size_t size;
	while (size = fread(buf, 1, BUFSIZ, finp))
	{
        fwrite(buf, 1, size, fout);
    }
	
	fclose(fout);
	fclose(finp);
	
	return val_true;
}
DEFINE_PRIM(file_copy, 2);

value file_delete_file(value filePath)
{	
	vector<wchar_t> filePath16 = preparePathIn(filePath);
	int err = ::_wremove(&filePath16[0]);
	if (err !=0 )
	{
		char buf[65536]; sprintf(buf, "Can't remove file '%s'.", val_string(filePath));
		failure(buf);
	}
	return val_true;
}
DEFINE_PRIM(file_delete_file, 1);

value file_delete_directory(value filePath)
{	
	vector<wchar_t> filePath16 = preparePathIn(filePath);
	int err = ::_wrmdir(&filePath16[0]);
	if (err !=0 )
	{
		char buf[65536]; sprintf(buf, "Can't remove directory '%s'.", val_string(filePath));
		failure(buf);
	}
	return val_true;
}
DEFINE_PRIM(file_delete_directory, 1);

#endif