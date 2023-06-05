#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "reader.h"

#define MAX_LINE_LENGTH 1024*1024*5

int count_comment_lines(char *filename) {
    FILE *in_file = fopen(filename, "r");
    if(in_file == NULL) {
        printf("Error! The file %s does not exist.\n", filename);
        return -1;
    }

    char line[MAX_LINE_LENGTH];
    int comment_lines = 0;
    while (fgets(line, sizeof(line), in_file)) {
        if (strncmp(line, ";;;", 3) == 0) {
            comment_lines++;
        } else {
            break;
        }
    }

    fclose(in_file);
    return comment_lines;
}

int detect_columns(char *filename, int offset) {
    FILE *in_file = fopen(filename, "r");
    if(in_file == NULL) {
        printf("Error! The file %s does not exist.\n", filename);
        return -1;
    }

    char line[MAX_LINE_LENGTH];
    int i;
    for(i = 0; i <= offset; i++) {
        fgets(line, sizeof(line), in_file);
    }

    int columns = 0;
    char* token = strtok(line, " ");
    while (token) {
        if (strcmp(token, "-") == 0) {
            break;
        }
        columns++;
        token = strtok(NULL, " ");
    }

    fclose(in_file);
    return columns - 1;
}


Matrix* read_file(char *filename, int rows, int cols, int offset) {
    FILE *in_file = fopen(filename, "r");
    if(in_file == NULL) {
        printf("Error! The file %s does not exist.\n", filename);
        return NULL;
    }

    char line[MAX_LINE_LENGTH];

    for(int i = 0; i < offset; i++) {
        if(!fgets(line, sizeof(line), in_file)) {
            fclose(in_file);
            return NULL;
        }
    }

    Matrix* matrix = (Matrix*)malloc(sizeof(Matrix));
    matrix->data = (char *)malloc(sizeof(char)*rows*cols);
    matrix->rows = rows;
    matrix->cols = cols;

    int i, j, number;
    for(i = 0; i < rows; i++) {
        for(j = 0; j < cols; j++) {
            if(fscanf(in_file, "%d", &number) != 1) {
                break;
            } 
            matrix->data[i*cols + j] = number;
        }
        if(j != cols || fscanf(in_file, " -\n") == EOF) {
            break;
        }
    }

    matrix->rows = i;
    matrix->cols = (i > 0) ? cols : 0;

    if(i == 0) {
        free(matrix->data);
        free(matrix);
        fclose(in_file);
        return NULL;
    }

    fclose(in_file);
    return matrix;
}

void free_matrix(Matrix* matrix) {
    if (matrix) {
        free(matrix->data);
        free(matrix);
    }
}
int main(void) {
    // Counting the commnets
    int comment_lines = count_comment_lines("dat.txt");
    printf("Comment lines: %d\n", comment_lines);

    // Detecting the number of columns
    int COLS = detect_columns("dat.txt", comment_lines);
    printf("Columns: %d\n", COLS);

    long long mem_size = 4LL * 1024 * 1024 * 1024; // 4GB of memory
    int loadable_rows = mem_size / (COLS * sizeof(char)); // rows can be loaded at once
    int offset = comment_lines;
    printf("-----------------------------------------------\n");
    printf("Loading %d rows at a time\n", loadable_rows);
    printf("-----------------------------------------------\n");

    while (1) {
        Matrix* my_matrix = read_file("dat.txt", loadable_rows, COLS, offset);

        if (my_matrix == NULL) {
            break;
        }

        for(int i = 0; i < my_matrix->rows; i++) {
            for(int j = 0; j < my_matrix->cols; j++) {
                printf("| %4d ", my_matrix->data[i*COLS + j]);
            }
            printf("|\n");
        }

        offset += my_matrix->rows;
        free_matrix(my_matrix);
    }
    return 0;
}