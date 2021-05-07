#ifndef _JPEGFILE_H_
#define _JPEGFILE_H_

#include <stdio.h>

int jpeg_save(unsigned char*data, int width, int height, int quality, const char*filename);
int jpeg_save_to_file(unsigned char*data, int width, int height, int quality, FILE*fi);
int jpeg_save_to_mem(unsigned char*data, int width, int height, int quality, unsigned char*dest, int destsize);
int jpeg_load(const char*filename, unsigned char**dest, int*width, int*height);
int jpeg_load_from_mem(unsigned char*_data, int size, unsigned char*dest, int width, int height);

#endif
