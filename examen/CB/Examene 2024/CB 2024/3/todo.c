#include <stdio.h>
#include <stdlib.h>

#include "file.h"

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

/* TODO a: Find `compute` parameters so that calling `compute`
 * function will return 0.
 */
void todo_a()
{
	int res;

	res = compute(0x0fff00ff, ((0x0fff00ff >> 1) ^ 0));
	if (!res) 
		printf("a) Perfect! Go on!\n");
	else
		printf("a) Wrong answer. Try again\n");
}


/* TODO b: Set `a` and `b` so that
 * `check_array` function will return 0.
 */
void todo_b(void) {
	int res;
	int a[] = {101, 102, 103, 104, 105, 106, 107};
	int b[] = {404, 408, 412, 416, 420, 424, 428};
	res = check_arrays(a, ARRAY_SIZE(a), b, ARRAY_SIZE(b));
	if (!res)
		printf("b) Perfect! Go on!\n");
	else
		printf("b) Wrong answer. Try again!\n");
}


/* TODO c: Indirectly call `secret` function using `read_string` */
void todo_c()
{
	read_string();
}
