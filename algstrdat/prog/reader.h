#ifndef READER_H
#define READER_H

typedef struct {
    char *data;
    int rows;
    int cols;
} Matrix;

int count_comment_lines(char *filename);
int detect_columns(char *filename, int offset);
Matrix* read_file(char *filename, int rows, int cols, int offset);
void free_matrix(Matrix* matrix);

#endif /* READER_H */
