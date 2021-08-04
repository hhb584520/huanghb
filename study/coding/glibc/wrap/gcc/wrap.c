// warp.c
#include <stdio.h>
#include <stdlib.h>
void* __real_malloc(size_t size);
void* __wrap_malloc(size_t size)
{
	printf("hhb __wrap_malloc called, size:%zd\n", size);
	return __real_malloc(size);
}
