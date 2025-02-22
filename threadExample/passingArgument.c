#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_THREADS 5

struct thread_data {
    int thread_id;     // ID of the thread
    int sum;           // A sum or any other number related to the thread
    const char *message;  // Message associated with the thread (const char* to avoid modifying)
};

struct thread_data thread_data_array[NUM_THREADS];  // Array to hold thread data

void *PrintHello(void *thread_arg) {
    struct thread_data *my_data;
    my_data = (struct thread_data *) thread_arg;  // Cast thread_arg to the correct type
    
    int taskid = my_data->thread_id;    // Access thread ID
    int sum = my_data->sum;              // Access sum (could be any data)
    const char *hello_msg = my_data->message;  // Access the message (const char* because it's constant)
    
    // Print the thread's details
    printf("Hello World! It's me, thread #%d! Sum is %d, Message: %s\n", taskid, sum, hello_msg);

    pthread_exit(NULL);  // Exit the thread
}

int main(int argc, char *argv[]) {
    pthread_t threads[NUM_THREADS];  // Array to hold thread identifiers
    int rc;
    long t;
    
    // Message array (using string literals, which are constant by default)
    const char *messages[] = {
        "Message 1",
        "Message 2",
        "Message 3",
        "Message 4",
        "Message 5"
    };

    for (t = 0; t < NUM_THREADS; t++) {
        // Initialize the data for each thread
        thread_data_array[t].thread_id = t;        // Set thread ID
        thread_data_array[t].sum = t * 10;         // Set sum (just an example)
        thread_data_array[t].message = messages[t]; // Assign message
        
        printf("In main: creating thread %ld\n", t);
        
        // Create a thread and pass a pointer to the thread's data structure
        rc = pthread_create(&threads[t], NULL, PrintHello, (void *) &thread_data_array[t]);
        if (rc) {
            printf("ERROR: return from pthread_create() is %d\n", rc);
            exit(-1);
        }
    }

    // Wait for all threads to complete
    for (t = 0; t < NUM_THREADS; t++) {
        pthread_join(threads[t], NULL);  // Ensure main waits for each thread
    }

    return 0;
}

