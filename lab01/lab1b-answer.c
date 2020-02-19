#include <stdio.h>
#include <string.h>
#define MAX 10

void reverseArray(char [], size_t);

int main(void) {
	char word[31];
	size_t len;

	printf("Enter up to 30 characters: ");
	fgets(word, 31, stdin);
	len = strlen(word);

	/* End-of-Line Check */
	if(word[len-1] == '\n') {
		len = len - 1;
		word[len] = '\0';
	}

	reverseArray(word, len);
	printf("The reverse is: %s\n", word);

	return 0;
}

void reverseArray(char arr[], size_t size) {
    // complete the function body
    char *start = arr;
    char *end = arr + size - 1;
    while (start < end) {
        *start ^= *end;
        *end ^= *start;
        *start ^= *end;
        
        start++;
        end--;
    }
}
