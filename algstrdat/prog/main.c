
#include<stdio.h>

#include"reader.h"

long max_line_length = 1024 * 1024 * 5; // 5 MiB ~ 2_621_438 columns

int main(void) {

    printf("The source file can contain at most %d columns!\n", (max_line_length-3)/2);

    // Counting the commnets
    int comment_lines = count_comment_lines("dat.txt");
    printf("Comment lines: %d\n", comment_lines);

    // Detecting the number of columns
    int n_columns = detect_columns("dat.txt", comment_lines);
    printf("Columns: %d\n", n_columns);

    long long mem_size = 4LL * 1024 * 1024 * 1024; // 4GB of memory
    int loadable_rows = mem_size / (n_columns * sizeof(char)); // rows can be loaded at once
    int offset = comment_lines;

    printf("-----------------------------------------------\n");
    printf("Loading %d rows at a time\n", loadable_rows);
    printf("-----------------------------------------------\n");

    while (1) {
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
        free_matrix(my_matrix);
    }
    return 0;
}