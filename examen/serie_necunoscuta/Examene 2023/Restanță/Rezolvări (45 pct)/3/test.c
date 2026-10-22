#include <stdio.h>

void joey(unsigned int a);
size_t chandler(unsigned int a, unsigned int b);
void ross(unsigned int a, unsigned int b, unsigned int *out, const unsigned char *msg);

static unsigned const char message[30];

int main(void)
{
	unsigned int out[7];
  size_t ret;

	joey(9);
	ret = chandler(150, 112);
	printf("ret: %zu\n", ret);
	ross(1, 0, out, "Unagi is a total state of awareness");

	return 0;
}
