#ifndef COMMON_H
#define	COMMON_H

#include <vector>
#include <neko.h>

std::vector<wchar_t> preparePathIn(value src);
value preparePathOut(const wchar_t *src);

#endif	/* COMMON_H */
