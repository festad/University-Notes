#include "ec.h"
#include <stdlib.h>
#include <stdio.h>

/*

PSEUDOCODE


procedure exact_cover(A)

    COV <- {}

    for i <- 1 to rows[A] do

        if A[i] == empty then
            break

        if A[i] == M then 
            insert {i} into COV
            break
        
        add to B the column relative to i

        for j <- 1 to i-1 do
            if intersect(A[j], A[i]) != empty then
                B[j,i] <- 0
            else
                I <- {i,j}
                U <- union(A[i], A[j])
                if U == M then
                    insert I into COV
                    B[j,i] <- 1
                else
                    B[j,i] <- 1
                    inter <- intersect(B[1:j-1, i], B[1:j-1, j])
                    if inter != empty then
                        explore(I, U, inter)

procedure explore(I, U, inter, COV)
    for all k in inter sorted in lexicographical order do
        i_temp <- union(I, {k})
        u_temp <- union(U, A[k])

        if u_temp == M then
            insert i_temp into COV
        else
            inter_temp <- intersect(inter, B[1:k-1, k])
            if inter_temp != empty then
                explore(i_temp, u_temp, inter_temp)

*/

// Check if a set represented by a matrix row is empty
int is_empty(char* row, int len) {
    for(int i = 0; i < len; i++) {
        if(row[i] == 1) return 0;
    }
    return 1;
}

// Check intersection of two sets represented by matrix rows
int intersect(char* row1, char* row2, int len) {
    for(int i = 0; i < len; i++) {
        if(row1[i] == 1 && row2[i] == 1) return 1;
    }
    return 0;
}

char* intersection_set(char* row1, char* row2, int len) {
    char* intersect_result = (char*)malloc(len * sizeof(char));
    for(int i = 0; i < len; i++) {
        intersect_result[i] = (row1[i] == 1 && row2[i] == 1) ? 1 : 0;
    }
    return intersect_result; // Remember to free this memory outside after usage
}

// Union of two sets represented by matrix rows
char* union_sets(char* row1, char* row2, int len) {
    char* union_result = (char*)malloc(len * sizeof(char));
    for(int i = 0; i < len; i++) {
        union_result[i] = (row1[i] == 1 || row2[i] == 1) ? 1 : 0;
    }
    return union_result;
}


// Given your pseudocode, I assume B is a 2D matrix. 
// I'm adding it here as a global variable for simplification purposes.
// In practice, a more robust solution might wrap this in a structure or pass it as a parameter.
char **B;

void explore(int* I, int I_len, char* U, char** inter, int inter_rows, Matrix* A, CovMatrix* cov) {
    for (int idx = 0; idx < inter_rows; idx++) {
        // k is the row index from inter
        int k = atoi(inter[idx]); // Assumes that inter stores integer strings

        int* i_temp = (int*)malloc((I_len + 1) * sizeof(int));
        for (int l = 0; l < I_len; l++) {
            i_temp[l] = I[l];
        }
        i_temp[I_len] = k;

        char* u_temp = union_sets(U, A->data + k * A->cols, A->cols);

        if (is_equal(u_temp, A->cols, 1)) { // Checking if u_temp == M
            cov->data = realloc(cov->data, (cov->rows + 1) * sizeof(char*));
            cov->data[cov->rows] = i_temp; 
            cov->rows++;
        } else {
            // Calculate intersect(inter, B[1:k-1, k])
            char** inter_temp = intersection_set(inter, B[k], A->cols);
            if (inter_temp != NULL && *inter_temp != NULL) {
                explore(i_temp, I_len + 1, u_temp, inter_temp, /* inter_temp_rows */, A, cov);
                // Remember to free inter_temp after done using it.
            }
        }
        free(u_temp);
        free(i_temp);
    }
}

CovMatrix* exact_cover(Matrix* A) {
    CovMatrix* cov = (CovMatrix*)malloc(sizeof(CovMatrix));
    cov->rows = 0;
    cov->cols = A->cols;
    cov->data = NULL;

    // Initialize B
    B = (char**)malloc(A->rows * sizeof(char*));
    for (int i = 0; i < A->rows; i++) {
        B[i] = (char*)malloc(A->rows * sizeof(char));
        memset(B[i], 0, A->rows * sizeof(char));
    }

    for(int i = 0; i < A->rows; i++) {
        if(is_empty(A->data + i * A->cols, A->cols)) {
            break;
        }

        if(is_equal(A->data + i * A->cols, A->cols, 1)) { // Checking if A[i] == M
            cov->data = realloc(cov->data, (cov->rows + 1) * sizeof(char*));
            cov->data[cov->rows] = clone_row(A->data + i * A->cols, A->cols);
            cov->rows++;
            break;
        }

        // Add to B the column relative to i - I'm assuming this means setting the column to 1.
        for (int j = 0; j < A->rows; j++) {
            B[j][i] = 1;
        }

        for(int j = 0; j < i; j++) {
            if(intersect(A->data + j * A->cols, A->data + i * A->cols, A->cols)) {
                B[j][i] = 0;
            } else {
                int I[] = {i, j}; 
                char* U = union_sets(A->data + i * A->cols, A->data + j * A->cols, A->cols);

                if(is_equal(U, A->cols, 1)) { // Checking if U == M
                    cov->data = realloc(cov->data, (cov->rows + 1) * sizeof(char*));
                    cov->data[cov->rows] = clone_row(U, A->cols);
                    cov->rows++;
                    B[j][i] = 1;
                } else {
                    B[j][i] = 1;
                    // Calculate intersect(B[1:j-1, i], B[1:j-1, j])
                    char** inter = intersection_set(B[j], B[i], A->cols);
                    if (inter != NULL && *inter != NULL) {
                        explore(I, 2, U, inter, /* number of rows in inter */, A, cov);
                        // Remember to free 'inter' after done using it.
                    }
                }
                free(U);
            }
        }
    }

    for (int i = 0; i < A->rows; i++) {
        free(B[i]);
    }
    free(B);
    return cov;
}


void free_cov(CovMatrix* cov) {
    if(cov) {
        for(int i = 0; i < cov->rows; i++) {
            free(cov->data[i]);
        }
        free(cov->data);
        free(cov);
    }
}

void write_partitions_to_file(CovMatrix* cov, const char* filename, int iterations) {
    FILE* file = fopen(filename, "w");
    if (!file) return;

    for (int i = 0; i < cov->rows && i < iterations; i++) {
        for (int j = 0; j < cov->cols; j++) {
            fprintf(file, "%c ", cov->data[i][j] + '0');  // Convert char to string representation
        }
        fprintf(file, "\n");
    }
    fclose(file);
}