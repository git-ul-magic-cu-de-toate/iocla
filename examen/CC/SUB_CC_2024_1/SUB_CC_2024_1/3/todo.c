#include <stdio.h>
#include <stdlib.h>

#include "file.h"

/* TODO a: Find `solve` parameters so that calling `solve`
 * function will return 0.
 */
void todo_a()
{
	int res;

	//res = solve(0xFBAE, 0xEBAC);
	res = solve(0xFBAE, 0xEbAC);
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
	catch_me();
    printf("c) Wrong answer. Try again!\n");
}