#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "reader.h"

// #define mem_size 1024*1024*5

extern long mem_size;

// (mem_size - 3) / 2 -> MAX_N_COLUMNS

int count_comment_lines(char *filename) {
    printf("mem_size: %d\n", mem_size);
    FILE *in_file = fopen(filename, "r");
    if(in_file == NULL) {
        printf("Error! The file %s does not exist.\n", filename);
        return -1;
    }

    char line[mem_size];
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

    char line[mem_size];
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

    char line[mem_size];

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