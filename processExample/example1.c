#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int glo_init_data = 99;
int glo_noninit_data;

// Demonstrates the segments of a process
void print_func() {
    int local_data = 9;
    printf("Process ID = %d\n", getpid());
    printf("Addresses of the process:\n");
    
    printf("Data segment:\n");
    printf(" 1. glo_init_data = %p\n\n", &glo_init_data);

    printf("BSS segment:\n");
    printf(" 2. glo_noninit_data = %p\n\n", &glo_noninit_data);

    printf("Code segment:\n");
    printf(" 3. print_func() = %p\n\n", &print_func);

    printf("Stack:\n");
    printf(" 4. local_data = %p\n\n", &local_data);
}

int main(int argc, char **argv) {
    print_func();
    return 0;
}
