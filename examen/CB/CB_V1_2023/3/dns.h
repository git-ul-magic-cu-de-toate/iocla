#pragma once

struct dns_entry {
    unsigned int ip;
    char hostname[24];
};

void task2(void *entries, int size, int target_ip);
