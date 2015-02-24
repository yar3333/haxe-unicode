#include <dirent.h>
#include <cstring>
#include <stdio.h>
#include <sys/stat.h>
#include "utf8.h"
#include "common.h"

using namespace std;

value filesystem_exists(value path)
{	
	vector<wchar_t> path16 = preparePath(path);
	return _waccess(&path16[0], F_OK) != -1 ? val_true : val_false;
}
DEFINE_PRIM(filesystem_exists, 1);

value filesystem_read_directory(value path)
{	
	vector<wchar_t> path16 = preparePath(path);

	_WDIR *dfd = _wopendir(&path16[0]);
	if (dfd == NULL)
	{
		char buf[65536]; sprintf(buf, "Can't open directory '%s'.", val_string(path));
		failure(buf);
	}

	vector<value> files;
	_wdirent *dp;
	while ((dp = _wreaddir(dfd)) != NULL)
	{
		if (wcscmp(dp->d_name, L".")==0 || wcscmp(dp->d_name, L"..")==0) continue;
		
		vector<wchar_t> name16;
		name16.assign(dp->d_name, dp->d_name + wcslen(dp->d_name));
		
		vector<char> name8;
		utf8::utf16to8(name16.begin(), name16.end(), back_inserter(name8));
		name8.push_back(0);
		
		files.push_back(alloc_string(&name8[0]));
	}
	_wclosedir(dfd);

	value r = alloc_array(files.size());
	memcpy(val_array_ptr(r), &files[0], sizeof(value) * files.size());
	
	return r;
}
DEFINE_PRIM(filesystem_read_directory, 1);

value filesystem_is_directory(value path)
{	
	vector<wchar_t> path16 = preparePath(path);
	
	struct _stat stbuf;
	if (_wstat(&path16[0], &stbuf ) == -1)
	{
		char buf[65536]; sprintf(buf, "Can't stat '%s'.", val_string(path));
		failure(buf);
	}
	
	return (stbuf.st_mode & S_IFMT ) == S_IFDIR ? val_true : val_false;
}
DEFINE_PRIM(filesystem_is_directory, 1);

value filesystem_rename(value src, value dest)
{	
	vector<wchar_t> src16 = preparePath(src);
	vector<wchar_t> dest16 = preparePath(dest);
	
	int r = _wrename(&src16[0], &dest16[0]);
	if (r)
	{
		char buf[65536]; sprintf(buf, "Can't rename '%s' to '%s'. Error code is %i.", val_string(src), val_string(dest), r);
		failure(buf);
	}
	
	return val_null;
}
DEFINE_PRIM(filesystem_rename, 2);
