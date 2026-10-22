#include <stdio.h>
#include <stdlib.h>

#include "file.h"

/* TODO a: Find `solve` parameters so that calling `solve`
 * function will return 0.
 */
void todo_a()
{
	int res;

	res = solve(23127, 6710);
	if (!res) 
		printf("a) Perfect! Go on!\n");
	else
		printf("a) Wrong answer. Try again\n");
}


/* TODO b: Read `buf` from standard input so that
 * `check_string` function will return 0.
 */
void todo_b(void) {
	char buf[1000] = {};
    int res;

	scanf("%s", buf);
	res = check_string(buf);
	if (!res)
		printf("b) Perfect! Go on!\n");
	else
		printf("b) Wrong answer. Try again!\n");
}


/* TODO c: Indirectly call `secret` function using `read_string` */
void todo_c()
{
	//catch_me();
    printf("c) Wrong answer. Try again!\n");
}

int main(int argc, char **argv)
{
	if (argc != 2) {
		fprintf(stderr, "Please run ./main {a|b|c}\n");
		return -1;
	}
	switch(argv[1][0]) {
		case 'a':
			todo_a();
			break;
		case 'b':
			todo_b();
			break;
		case 'c':
			todo_c();
			break;
		default:
			fprintf(stderr, "Please run ./main {a|b|c}\n");
			return -1;
	}

	return 0;
}