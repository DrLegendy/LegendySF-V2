#include "StdAfx.h"
#include "JpegFile.h"
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

#include <libjpeg/jpeglib.h>
#include <libjpeg/jpegLibLink.h>

#define OUTBUFFER_SIZE 0x8000

static FILE*fi;
static JOCTET * buffer;
static unsigned char*dest;
static int len;
static int destlen;
static unsigned char*dataX;
static int pos;
static int sizeX;

static void file_init_destination(j_compress_ptr cinfo)
{
  struct jpeg_destination_mgr*dmgr =
      (struct jpeg_destination_mgr*)(cinfo->dest);
  buffer = (JOCTET*)malloc(OUTBUFFER_SIZE);
  if(!buffer) {
      perror("malloc");
      printf("Out of memory!\n");
      exit(1);
  }
  dmgr->next_output_byte = buffer;
  dmgr->free_in_buffer = OUTBUFFER_SIZE;
}

static boolean file_empty_output_buffer(j_compress_ptr cinfo)
{
  struct jpeg_destination_mgr*dmgr =
      (struct jpeg_destination_mgr*)(cinfo->dest);
  if(fi)
    fwrite(buffer, OUTBUFFER_SIZE, 1, fi);
  dmgr->next_output_byte = buffer;
  dmgr->free_in_buffer = OUTBUFFER_SIZE;
  return 1;
}

static void file_term_destination(j_compress_ptr cinfo)
{ struct jpeg_destination_mgr*dmgr =
      (struct jpeg_destination_mgr*)(cinfo->dest);
  if(fi)
    fwrite(buffer, OUTBUFFER_SIZE-dmgr->free_in_buffer, 1, fi);
  free(buffer);
  buffer = 0;
  dmgr->free_in_buffer = 0;
}

static void mem_init_destination(j_compress_ptr cinfo)
{
  struct jpeg_destination_mgr*dmgr =
      (struct jpeg_destination_mgr*)(cinfo->dest);
  dmgr->next_output_byte = dest;
  dmgr->free_in_buffer = destlen;
}

static boolean mem_empty_output_buffer(j_compress_ptr cinfo)
{
    printf("jpeg mem overflow!\n");
    exit(1);
}

static void mem_term_destination(j_compress_ptr cinfo)
{
  struct jpeg_destination_mgr*dmgr =
      (struct jpeg_destination_mgr*)(cinfo->dest);
  len = destlen - dmgr->free_in_buffer;
  dmgr->free_in_buffer = 0;
}

int jpeg_save(unsigned char*data, int width, int height, int quality, const char*filename)
{
  struct jpeg_destination_mgr mgr;
  struct jpeg_compress_struct cinfo;
  struct jpeg_error_mgr jerr;
  int t;

  if(filename) {
    fi = fopen(filename, "wb");
	if(fi == NULL)
		return 0;
  } else
    fi = NULL;

  memset(&cinfo, 0, sizeof(cinfo));
  memset(&jerr, 0, sizeof(jerr));
  memset(&mgr, 0, sizeof(mgr));
  cinfo.err = jpeg_std_error(&jerr);
  jpeg_create_compress(&cinfo);

  mgr.init_destination = file_init_destination;
  mgr.empty_output_buffer = file_empty_output_buffer;
  mgr.term_destination = file_term_destination;
  cinfo.dest = &mgr;

  // init compression

  cinfo.image_width  = width;
  cinfo.image_height = height;
  cinfo.input_components = 3;
  cinfo.in_color_space = JCS_RGB;
  jpeg_set_defaults(&cinfo);
  jpeg_set_quality(&cinfo,quality,TRUE);

  //jpeg_write_tables(&cinfo);
  //jpeg_suppress_tables(&cinfo, TRUE);
  jpeg_start_compress(&cinfo, FALSE);

  for(t=0;t<height;t++) {
    unsigned char*data2 = &data[width*3*t];
    jpeg_write_scanlines(&cinfo, &data2, 1);
  }
  jpeg_finish_compress(&cinfo);

  if(fi)
    fclose(fi);
  jpeg_destroy_compress(&cinfo);
  return 1;
}

int jpeg_save_to_file(unsigned char*data, int width, int height, int quality, FILE*_fi)
{
  struct jpeg_destination_mgr mgr;
  struct jpeg_compress_struct cinfo;
  struct jpeg_error_mgr jerr;
  int t;

  fi = _fi;

  memset(&cinfo, 0, sizeof(cinfo));
  memset(&jerr, 0, sizeof(jerr));
  memset(&mgr, 0, sizeof(mgr));
  cinfo.err = jpeg_std_error(&jerr);
  jpeg_create_compress(&cinfo);

  mgr.init_destination = file_init_destination;
  mgr.empty_output_buffer = file_empty_output_buffer;
  mgr.term_destination = file_term_destination;
  cinfo.dest = &mgr;

  // init compression

  cinfo.image_width  = width;
  cinfo.image_height = height;
  cinfo.input_components = 3;
  cinfo.in_color_space = JCS_RGB;
  jpeg_set_defaults(&cinfo);
  cinfo.dct_method = JDCT_IFAST;
  jpeg_set_quality(&cinfo,quality,TRUE);

  //jpeg_write_tables(&cinfo);
  //jpeg_suppress_tables(&cinfo, TRUE);
  jpeg_start_compress(&cinfo, FALSE);

  for(t=0;t<height;t++) {
    unsigned char*data2 = &data[width*3*t];
    jpeg_write_scanlines(&cinfo, &data2, 1);
  }
  jpeg_finish_compress(&cinfo);
  jpeg_destroy_compress(&cinfo);
  return 1;
}

int jpeg_save_to_mem(unsigned char*data, int width, int height, int quality, unsigned char*_dest, int _destlen)
{
  struct jpeg_destination_mgr mgr;
  struct jpeg_compress_struct cinfo;
  struct jpeg_error_mgr jerr;
  int t;

  memset(&cinfo, 0, sizeof(cinfo));
  memset(&jerr, 0, sizeof(jerr));
  memset(&mgr, 0, sizeof(mgr));
  cinfo.err = jpeg_std_error(&jerr);
  jpeg_create_compress(&cinfo);

  dest = _dest;
  len = 0;
  destlen = _destlen;

  mgr.init_destination = mem_init_destination;
  mgr.empty_output_buffer = mem_empty_output_buffer;
  mgr.term_destination = mem_term_destination;
  cinfo.dest = &mgr;

  // init compression

  cinfo.image_width  = width;
  cinfo.image_height = height;
  cinfo.input_components = 3;
  cinfo.in_color_space = JCS_RGB;
  jpeg_set_defaults(&cinfo);
  cinfo.dct_method = JDCT_IFAST;
  jpeg_set_quality(&cinfo,quality,TRUE);

  jpeg_start_compress(&cinfo, FALSE);
  for(t=0;t<height;t++) {
    unsigned char*data2 = &data[width*3*t];
    jpeg_write_scanlines(&cinfo, &data2, 1);
  }
  jpeg_finish_compress(&cinfo);
  jpeg_destroy_compress(&cinfo);
  return len;
}

void mem_init_source (j_decompress_ptr cinfo)
{
    struct jpeg_source_mgr* mgr = cinfo->src;
    mgr->next_input_byte = dataX;
    mgr->bytes_in_buffer = sizeX;
    //printf("init %d\n", size - mgr->bytes_in_buffer);
}

boolean mem_fill_input_buffer (j_decompress_ptr cinfo)
{
    struct jpeg_source_mgr* mgr = cinfo->src;
    printf("fill %d\n", sizeX - mgr->bytes_in_buffer);
    return 0;
}

void mem_skip_input_data (j_decompress_ptr cinfo, long num_bytes)
{
    struct jpeg_source_mgr* mgr = cinfo->src;
    printf("skip %d +%d\n", sizeX - mgr->bytes_in_buffer, num_bytes);
    if(num_bytes<=0)
	return;
    mgr->next_input_byte += num_bytes;
    mgr->bytes_in_buffer -= num_bytes;
}

boolean mem_resync_to_restart (j_decompress_ptr cinfo, int desired)
{
    struct jpeg_source_mgr* mgr = cinfo->src;
    printf("resync %d\n", sizeX - mgr->bytes_in_buffer);
    mgr->next_input_byte = dataX;
    mgr->bytes_in_buffer = sizeX;
    return 1;
}

void mem_term_source (j_decompress_ptr cinfo)
{
    struct jpeg_source_mgr* mgr = cinfo->src;
    //printf("term %d\n", size - mgr->bytes_in_buffer);
}

int jpeg_load_from_mem(unsigned char*_data, int _size, unsigned char*dest, int width, int height)
{
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
    struct jpeg_source_mgr mgr;
    int y;
	//int x;

    dataX = _data;
    sizeX = _size;

    jpeg_create_decompress(&cinfo);

    mgr.next_input_byte = dataX;
    mgr.bytes_in_buffer = sizeX;
    mgr.init_source        =mem_init_source ;
    mgr.fill_input_buffer  =mem_fill_input_buffer ;
    mgr.skip_input_data    =mem_skip_input_data ;
    mgr.resync_to_restart  =mem_resync_to_restart ;
    mgr.term_source        =mem_term_source ;

    cinfo.err = jpeg_std_error(&jerr);
    cinfo.src = &mgr;

    jpeg_read_header(&cinfo, TRUE);
    jpeg_start_decompress(&cinfo);

    for(y=0;y<height;y++) {
	unsigned char*j = &dest[width*y*3];
	jpeg_read_scanlines(&cinfo,&j,1);
    }

    jpeg_finish_decompress(&cinfo);
    jpeg_destroy_decompress(&cinfo);
    return 1;
}

typedef struct _RGBA {
    unsigned char a,r,g,b;
} RGBA;

typedef unsigned char U8;

int jpeg_load(const char*filename, unsigned char**dest, int*_width, int*_height)
{
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
    //struct jpeg_source_mgr mgr;

    FILE*fi = fopen(filename, "rb");
    if(!fi) {
        fprintf(stderr, "Couldn't open file %s\n", filename);
	return 0;
    }

    cinfo.err = jpeg_std_error(&jerr);
    jpeg_create_decompress(&cinfo);
    jpeg_stdio_src(&cinfo, fi);
    jpeg_read_header(&cinfo, TRUE);
    jpeg_start_decompress(&cinfo);

    U8*scanline = (U8 *)malloc(4 * cinfo.output_width);

    int width = *_width = cinfo.output_width;
    int height = *_height = cinfo.output_height;
    *dest = (unsigned char*)malloc(width*height*4);

    int y;
    for (y=0;y<height;y++) {
	int x;
	U8 *js = scanline;
        RGBA*line = &((RGBA*)(*dest))[y*width];

	jpeg_read_scanlines(&cinfo, &js, 1);
	if (cinfo.out_color_space == JCS_GRAYSCALE) {
	    for (x = 0; x < width; x++) {
		line[x].a = 255;
		line[x].r = line[x].g = line[x].b = js[x];
	    }
	} else if (cinfo.out_color_space == JCS_RGB) {
	    for (x = width - 1; x >= 0; x--) {
		line[x].a = 255;
		line[x].r = js[x*3+0];
		line[x].g = js[x*3+1];
		line[x].b = js[x*3+2];
	    }
	} else if (cinfo.out_color_space == JCS_YCCK) {
	    fprintf(stderr, "Error: Can't convert YCCK to RGB.\n");
	    return 0;
	} else if (cinfo.out_color_space == JCS_YCbCr) {
	    for (x = 0; x < width; x++) {
		int y = js[x * 3 + 0];
		int u = js[x * 3 + 1];
		int v = js[x * 3 + 1];
		line[x].a = 255;
		line[x].r = y + ((360 * (v - 128)) >> 8);
		line[x].g = y - ((88 * (u - 128) + 183 * (v - 128)) >> 8);
		line[x].b = y + ((455 * (u - 128)) >> 8);
	    }
	} else if (cinfo.out_color_space == JCS_CMYK) {
	    for (x = 0; x < width; x++) {
		int white = 255 - js[x * 4 + 3];
		line[x].a = 255;
		line[x].r = white - ((js[x * 4] * white) >> 8);
		line[x].g = white - ((js[x * 4 + 1] * white) >> 8);
		line[x].b = white - ((js[x * 4 + 2] * white) >> 8);
	    }
	}
    }

    free(scanline);

    jpeg_finish_decompress(&cinfo);
    jpeg_destroy_decompress(&cinfo);
    fclose(fi);
    return 1;
}
