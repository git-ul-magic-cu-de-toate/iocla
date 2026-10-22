#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define NMAX 100

void set_operation(char operand, char operation[5], int *print_diff)
{
	switch (operand) {
	case '^':
		strcpy(operation, "XOR");
		*print_diff = 6;
		break;
	case '|':
		strcpy(operation, "OR");
		*print_diff = 6;
		break;
	case '&':
		strcpy(operation, "AND");
		*print_diff = 6;
		break;
	case '+':
		strcpy(operation, "ADD");
		*print_diff = 6;
		break;
	case '-':
		strcpy(operation, "SUB");
		*print_diff = 6;
		break;
	case '*':
		strcpy(operation, "MUL");
		*print_diff = 6;
		break;
	case '/':
		strcpy(operation, "DIV");
		*print_diff = 6;
		break;
	case '<':
		strcpy(operation, "SHL");
		*print_diff = 7;
		break;
	case '>':
		strcpy(operation, "SHR");
		*print_diff = 7;
		break;
	default:
		strcpy(operation, "MOV");
		*print_diff = 2;
		break;
	}
}

void case_semi_colon(char line[NMAX])
{
	char operation[5];

	line[strlen(line) - 2] = '\0'; // remove the newline and ';'

	char *equal_sign = strchr(line, '=');
	char operand = *(equal_sign + 4);
	char first = *(equal_sign - 2);
	int print_diff;

	set_operation(operand, operation, &print_diff);

	// pointer to the value right after the operand
	char *value = equal_sign + print_diff;
	if (operand == '*') {
		if (first == 'a') {
			printf("%s %s\n", operation, value);
		} else {
			printf("MOV eax, e%cx\n", first);
			if (*(value) >= '0' && *(value) <= '9')
				printf("%s %s\n", operation, value);
			else
				printf("%s e%sx\n", operation, value);

			printf("MOV e%cx, eax\n", first);
		}
	} else if (operand == '/') {
		if (*(value) == '0') {
			printf("Error\n");
			return;
		}

		printf("MOV eax, e%cx\n", first);
		if (*(value) >= '1' && *(value) <= '9')
			printf("%s %s\n", operation, value);
		else
			printf("%s e%sx\n", operation, value);

		printf("MOV e%cx, eax\n", first);
	} else {
		// sign is '^', '|', '&', '+', '-', '<<' or '>>'
		if (*(value) >= '0' && *(value) <= '9')
			printf("%s e%cx, %s\n", operation, first, value);
		else
			printf("%s e%cx, e%sx\n", operation, first, value);
	}
}

void case_statement(char line[NMAX], int *for_loop, char *for_letter,
					int *while_loop, int *if_statement)
{
	int diff_condition;

	if (line[0] == 'i') {
		// if
		*if_statement = 1;

		line[strlen(line) - 4] = '\0'; // remove ") {\n" string

		diff_condition = 6;

	} else if (line[0] == 'w') {
		// while
		*while_loop = 1;

		line[strlen(line) - 4] = '\0'; // remove ") {\n" string

		diff_condition = 9;

		printf("start_loop:\n");
	} else {
		// for
		*for_loop = 1;
		*for_letter = line[5];

		line[strlen(line) - 15] = '\0'; // remove ";x = x + 1) {\n"

		diff_condition = 14;

		printf("MOV e%cx, 0\n", line[5]);
		printf("start_loop:\n");
	}

	// pointer for conditional operand
	char *cond_sign = line + diff_condition;

	// find the actual operand
	char condition[5];
	strcpy(condition, cond_sign);
	condition[2] = '\0';

	char first = *(cond_sign - 2);

	// value points to the string after the operand
	char *value;
	if (*(cond_sign + 1) == ' ')
		value = cond_sign + 2;
	else
		value = cond_sign + 3;

	printf("CMP e%cx, %s\n", first, value);

	if (strcmp(condition, "==") == 0)
		printf("JNE end_label\n");
	else if (strcmp(condition, "<=") == 0)
		printf("JG end_label\n");
	else if (strcmp(condition, ">=") == 0)
		printf("JL end_label\n");
	else if (strcmp(condition, "< ") == 0)
		printf("JGE end_label\n");
	else if (strcmp(condition, "> ") == 0)
		printf("JLE end_label\n");
}

int main(void)
{
	char line[NMAX];
	int for_loop = 0;
	char for_letter;
	int while_loop = 0;
	int if_statement = 0;

	while (fgets(line, NMAX, stdin)) {
		if (line[strlen(line) - 2] == ';') {
			// line doesn't contain "if", "for" or "while"

			case_semi_colon(line);
		} else if (line[strlen(line) - 2] == '{') {
			// line contains "if", "for" or "while"

			case_statement(line, &for_loop, &for_letter,
						   &while_loop, &if_statement);
		} else {
			// line that only contains '}'

			if (for_loop) {
				printf("ADD e%cx, 1\n", for_letter);
				printf("JMP start_loop\n");
				printf("end_loop:\n");
			}

			if (while_loop) {
				printf("JMP start_loop\n");
				printf("end_label:\n");
			}

			if (if_statement)
				printf("end_label:\n");
		}
	}

	return 0;
}
