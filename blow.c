
/* Program to write to stdout forever */

#include <stdio.h>

static void fill_buffer(char*buffer, size_t buffer_size)
{
	int space_left = buffer_size;
	while (space_left>0) {
		space_left -= snprintf(buffer+buffer_size-space_left, space_left,"Buffer write %d\n", space_left);
	}
}

int main()
{
	int ret = 0;
	size_t buffer_size = 4000;
	char *buffer = (char*)malloc(buffer_size);
	if (NULL == buffer) {
		exit(1);
	}
	fill_buffer(buffer,buffer_size);
	while (1) {
		ret = fwrite(buffer,1,buffer_size,stdout);
		if (buffer_size != ret) {
			break;
		}
	}
	return 0;
}
