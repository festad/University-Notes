#include<stdio.h>
#include"reader.h"

// Custom memory size (RAM in bytes)
long long mem_size = 1024*1024;

int main(void) {

    // Approximating the maximum number of columns given a custom memory size
    printf("Given that the available ram is %ldB\n", mem_size);
    printf("each file describing a problem can contain at most %ld columns!\n", (mem_size-3)/2);

    // Counting the comments
    int comment_lines = count_comment_lines("dat.txt");
    printf("Comment lines: %d\n", comment_lines);

    // Detecting the number of columns
    int n_columns = detect_columns("dat.txt", comment_lines);
    printf("Columns: %d\n", n_columns);

    // 

    // Calculating the number of rows that can be loaded at once,
    // given the memory size and the number of columns, 
    // in theory if the number of columns was big enough,
    // the number of loadable rows would be 1
    int loadable_rows = mem_size / (n_columns * sizeof(char)); // rows can be loaded at once
    int offset = comment_lines;

    printf("-----------------------------------------------\n");
    printf("Loading %d rows at a time\n", loadable_rows);
    printf("-----------------------------------------------\n");

    int batch = 0;

    while (1) {
        printf("Batch: %d\n", batch);

        Matrix* my_matrix = read_file("dat.txt", loadable_rows, n_columns, offset);

        if (my_matrix == NULL) {
            break;
        }

        for(int i = 0; i < my_matrix->rows; i++) {
            for(int j = 0; j < my_matrix->cols; j++) {
                printf("| %4d ", my_matrix->data[i*n_columns + j]);
            }
            printf("|\n");
        }

        offset += my_matrix->rows;
        batch++;
        free_matrix(my_matrix);
    }
    return 0;
}