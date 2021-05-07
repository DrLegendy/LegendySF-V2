#include "stdafx.h"
#include "TextTag.h"
#include "Util.h"

int GetTextTag(const wchar_t * src, int maxLen, int & tagLen, std::wstring & extraInfo)
{
    tagLen = 1;

    if (maxLen < 2 || *src != L'|')
        return TEXT_TAG_PLAIN;

    const wchar_t * cur = ++src;

    if (*cur == L'c') // color
    {
        if (maxLen < 10)
            return TEXT_TAG_PLAIN;

        tagLen = 10;
        extraInfo.assign(++cur, 8);
        return TEXT_TAG_COLOR;
    }
    else if (*cur == L'|')
    {
        tagLen = 2;
        return TEXT_TAG_TAG;
    }
    else if (*cur == L'r') // restore color
    {
        tagLen = 2;
        return TEXT_TAG_RESTORE_COLOR;
    }
    else if (*cur == L'H')
    {
        tagLen = 2;
        return TEXT_TAG_HYPERLINK_START;
    }
    else if (*cur == L'h') // end of hyperlink
    {
        tagLen = 2;
        return TEXT_TAG_HYPERLINK_END;
    }
#ifdef ENABLE_EMOJI_SYSTEM
	else if (*cur == L'E') // emoji |Epath/emo|e
	{
		tagLen = 2;
		return TEXT_TAG_EMOJI_START;
	}
	else if (*cur == L'e') // end of emoji
	{
		tagLen = 2;
		return TEXT_TAG_EMOJI_END;
	}
#endif

    return TEXT_TAG_PLAIN;
}

std::wstring GetTextTagOutputString(const wchar_t * src, int src_len)
{
    int len;
	std::wstring dst;
	std::wstring extraInfo;
    int output_len = 0;
    int hyperlinkStep = 0;

    for (int i = 0; i < src_len; )
    {
        int tag = GetTextTag(&src[i], src_len - i, len, extraInfo);

        if (tag == TEXT_TAG_PLAIN || tag == TEXT_TAG_TAG)
        {
            if (hyperlinkStep == 0)
			{
                ++output_len;
				dst += src[i];
			}
        }
        else if (tag == TEXT_TAG_HYPERLINK_START)
            hyperlinkStep = 1;
        else if (tag == TEXT_TAG_HYPERLINK_END)
            hyperlinkStep = 0;
#ifdef ENABLE_EMOJI_SYSTEM
		else if (tag == TEXT_TAG_EMOJI_START)
			hyperlinkStep = 1;
		else if (tag == TEXT_TAG_EMOJI_END)
			hyperlinkStep = 0;
#endif

        i += len;
    }
	return dst;
}

int GetTextTagInternalPosFromRenderPos(const wchar_t * src, int src_len, int offset)
{
    int len;
	std::wstring dst;
	std::wstring extraInfo;
    int output_len = 0;
    int hyperlinkStep = 0;
	bool color_tag = false;
	int internal_offset = 0;

    for (int i = 0; i < src_len; )
    {
        int tag = GetTextTag(&src[i], src_len - i, len, extraInfo);

        if (tag == TEXT_TAG_COLOR)
		{
			color_tag = true;
			internal_offset = i;
		}
		else if (tag == TEXT_TAG_RESTORE_COLOR)
		{
			color_tag = false;
		}
        else if (tag == TEXT_TAG_PLAIN || tag == TEXT_TAG_TAG)
        {
            if (hyperlinkStep == 0)
			{
				if (!color_tag)
					internal_offset = i;

				if (offset <= output_len)
					return internal_offset;

                ++output_len;
				dst += src[i];
			}
        }
        else if (tag == TEXT_TAG_HYPERLINK_START)
            hyperlinkStep = 1;
        else if (tag == TEXT_TAG_HYPERLINK_END)
            hyperlinkStep = 0;
#ifdef ENABLE_EMOJI_SYSTEM
		else if (tag == TEXT_TAG_EMOJI_START)
			hyperlinkStep = 1;
		else if (tag == TEXT_TAG_EMOJI_END)
			hyperlinkStep = 0;
#endif

        i += len;
    }

	return internal_offset;
}

int GetTextTagOutputLen(const wchar_t * src, int src_len)
{
    int len;
    std::wstring extraInfo;
    int output_len = 0;
    int hyperlinkStep = 0;

    for (int i = 0; i < src_len; )
    {
        int tag = GetTextTag(&src[i], src_len - i, len, extraInfo);

        if (tag == TEXT_TAG_PLAIN || tag == TEXT_TAG_TAG)
        {
            if (hyperlinkStep == 0)
                ++output_len;
        }
        else if (tag == TEXT_TAG_HYPERLINK_START)
            hyperlinkStep = 1;
        else if (tag == TEXT_TAG_HYPERLINK_END)
            hyperlinkStep = 0;
#ifdef ENABLE_EMOJI_SYSTEM
		else if (tag == TEXT_TAG_EMOJI_START)
			hyperlinkStep = 1;
		else if (tag == TEXT_TAG_EMOJI_END)
			hyperlinkStep = 0;
#endif

        i += len;
    }
    return output_len;
}

int FindColorTagStartPosition(const wchar_t * src, int src_len)
{
    if (src_len < 2)
        return 0;

    const wchar_t * cur = src;

	// @fixme012
	wchar_t wcStarts = L'c';
	wchar_t wcEnds = L'r';
	if (GetDefaultCodePage() == CP_ARABIC)
	{
		wcStarts = L'h';
		wcEnds = L'h';
	}

    if (*cur == wcEnds && *(cur - 1) == L'|')
    {
	    int len = src_len;

        if (len >= 2 && *(cur - 2) == L'|')
            return 1;

        cur -= 2;
        len -= 2;

        while (len > 1)
        {
            if (*cur == wcStarts && *(cur - 1) == L'|')
                return (src - cur) + 1;

            --cur;
            --len;
        }
        return (src_len);
    }
	else if (*cur == L'|' && *(cur - 1) == L'|')
		return 1;

    return 0;
}

int FindColorTagEndPosition(const wchar_t * src, int src_len)
{
	const wchar_t * cur = src;

	// @fixme012
	wchar_t wcStarts = L'c';
	wchar_t wcEnds = L'r';
	if (GetDefaultCodePage() == CP_ARABIC)
	{
		wcStarts = L'h';
		wcEnds = L'h';
	}

	if (src_len >= 4 && *cur == L'|' && *(cur + 1) == wcStarts)
	{
		int left = src_len - 2;
		cur += 2;

		while (left > 1)
		{
			if (*cur == L'|' && *(cur + 1) == wcEnds)
				return (cur - src) + 1;

			--left;
			++cur;
		}
	}
	else if (src_len >= 2 && *cur == L'|' && *(cur + 1) == L'|')
		return 1;

	return 0;
}
