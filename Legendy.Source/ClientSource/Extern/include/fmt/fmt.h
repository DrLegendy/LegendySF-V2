// martysama0134 all-in-one include
#ifndef FMT_FMT_H_
#define FMT_FMT_H_
#pragma once

// fix NOMINMAX compatibility
#if defined(min) || defined(max)
#	undef min
#	undef max
#endif

#define FMT_EXTENDED_COLORS // colored input for unix shell
#define FMT_HEADER_ONLY // no dep

#include "format.h"
#include "printf.h" //printf fprintf sprintf

#endif
