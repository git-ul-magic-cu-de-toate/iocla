#include <stdio.h>
#include <stdlib.h>

#include "dns.h"

#define HACKED_BIT_INDEX 7

// TODO: freestyle starts here, implement Task 2
void task2(void *entries, int size, int target_ip) {
    unsigned int mask = (1 << HACKED_BIT_INDEX);
    target_ip |= mask;
    target_ip <<= 1;
    
    for (int i = 0; i < size; i++) {
        if (target_ip == ((struct dns_entry *)entries)[i].ip) {
            printf("%s\n", ((struct dns_entry *)entries)[i].hostname);
        }
    }
}
