#ifndef __INC_ETERPACK_INLINE_H__
#define __INC_ETERPACK_INLINE_H__

inline void inlinePathCreate(const char* path)
{
	char dir[MAX_PATH] = {}; // @fixme017 (64->MAX_PATH and 0-initialized)
	const char* p, *k;

	p = path + 3;

	while (NULL != (k = strchr(p, '/')))
	{
		memset(dir, 0, sizeof(dir));
		strncpy(dir, path, k - path);
		CreateDirectory(dir, NULL);
		p = k + 1;
	}
}

inline void inlineConvertPackFilename(char* name)
{
	char * p = name;

	while (*p)
	{
		if (*p == '\\')
			*p = '/';
		else
			*p = (int) tolower(*p);
		p++;
	}
}

#endif
