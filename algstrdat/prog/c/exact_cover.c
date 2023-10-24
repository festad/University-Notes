/*

Solving the exact cover problem.

Sample input file:

--------------------------------
;;; Example exact cover problem
1 1 1 0 0 0 -
0 0 0 1 1 1 -
1 0 0 1 0 0 -
0 1 0 0 1 0 -
0 0 1 0 0 1 -
--------------------------------

Solution:
[0,1]
[2,3,4]

A <- input file, N*M,
    N = number of sets
    M = number of elements of the domain

B <- will become N*N at the end of the algorithm

*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MEM_SIZE 1024 * 1024

typedef struct Matrix {
    int** data;  // Array of arrays to store the matrix
    int rows;   // Number of sets in the input file
    int cols;   // Cardinality of the domain
} Matrix;

typedef struct COV {
    int** sets;   // Pointer to an array of pointers
    int size;     // Number of stored sets
    int capacity; // Capacity of the storage
} COV;

typedef struct { // for B
    int* data;
    int len;
    int capacity;
} DynamicArray;

void init_array(DynamicArray* arr, int cap) {
    arr->data = malloc(cap * sizeof(int));
    arr->len = 0;
    arr->capacity = cap;
}

void append(DynamicArray* arr, int value) {
    if (arr->len == arr->capacity) {
        arr->capacity *= 2;
        arr->data = realloc(arr->data, arr->capacity * sizeof(int));
    }
    arr->data[arr->len++] = value;
}

void extend(DynamicArray* arr, int* values, int n_values) {
    for (int i = 0; i < n_values; i++) {
        append(arr, values[i]);
    }
}


// Handling the input file

int count_comment_lines(const char* filename) {
    FILE* f = fopen(filename, "r");
    if (!f) {
        perror("Failed to open the file");
        exit(1);
    }

    int count = 0;
    char line[1024]; // assuming line length won't exceed this limit

    while (fgets(line, sizeof(line), f)) {
        if (strncmp(line, ";;;", 3) == 0) {
            count++;
        }
    }

    fclose(f);
    return count;
}

int detect_columns(const char* filename, int offset) {
    FILE* f = fopen(filename, "r");
    if (!f) {
        perror("Failed to open the file");
        exit(1);
    }

    for (int i = 0; i < offset; i++) {
        fgets(f, sizeof(char) * MEM_SIZE, f);  // skip lines
    }

    char line[1024]; 
    fgets(line, sizeof(line), f);

    int count = 0;
    char* token = strtok(line, " ");
    while (token) {
        if (strcmp(token, "-") != 0) {
            count++;
        }
        token = strtok(NULL, " ");
    }

    fclose(f);
    return count;
}

Matrix read_file(const char* filename, int rows, int cols, int offset) {
    FILE* f = fopen(filename, "r");
    if (!f) {
        perror("Failed to open the file");
        exit(1);
    }

    for (int i = 0; i < offset; i++) {
        fgets(f, sizeof(char) * MEM_SIZE, f);  // skip lines
    }

    Matrix matrix;
    matrix.data = (int*) malloc(rows * cols * sizeof(int));
    matrix.rows = 0; 
    matrix.cols = cols;

    char line[1024];
    for (int i = 0; i < rows && fgets(line, sizeof(line), f); i++) {
        int idx = 0;
        char* token = strtok(line, " ");
        while (token && idx < cols) {
            matrix.data[i * cols + idx] = atoi(token);
            token = strtok(NULL, " ");
            idx++;
        }
        matrix.rows++;
    }

    fclose(f);
    return matrix;
}

// Handling COV

COV create_cov() {
    COV cov;
    cov.size = 0;
    cov.capacity = 10; // Initial capacity
    cov.sets = (int**) malloc(cov.capacity * sizeof(int*));
    return cov;
}

void add_to_cov(COV* cov, int* set, int length) {
    if (cov->size == cov->capacity) {
        cov->capacity *= 2;
        cov->sets = (int**) realloc(cov->sets, cov->capacity * sizeof(int*));
    }
    cov->sets[cov->size] = (int*) malloc(length * sizeof(int));
    memcpy(cov->sets[cov->size], set, length * sizeof(int));
    cov->size++;
}

void add_cov(COV* cov, int value) {
    int* single_set = (int*) malloc(2 * sizeof(int)); // One for length, one for value
    single_set[0] = 1;  // Length of the set
    single_set[1] = value;
    add_to_cov(cov, single_set, 2);
    free(single_set); // add_to_cov already makes a copy so we can free it here
}

void free_cov(COV* cov) {
    for (int i = 0; i < cov->size; i++) {
        free(cov->sets[i]);
    }
    free(cov->sets);
}

void print_cov(const COV* cov) {
    for (int i = 0; i < cov->size; i++) {
        int* current_set = cov->sets[i];
        // Assuming the length of each set is stored at the 0th index of the set
        int set_length = current_set[0];
        
        for (int j = 1; j <= set_length; j++) {
            printf("S_%d", current_set[j] + 1); // +1 to match Python's 1-based index
            if (j < set_length) {
                printf(", ");
            }
        }
        printf("\n");
    }
}


// Helper functions for EC and explore

bool intersect(int* row1, int* row2, int length) {
    for (int i = 0; i < length; i++) {
        if (row1[i] == 1 && row2[i] == 1) {
            return true;
        }
    }
    return false;
}

int* union_arrays(int* row1, int* row2, int length) {
    int* result = (int*) malloc(length * sizeof(int));
    for (int i = 0; i < length; i++) {
        result[i] = row1[i] | row2[i];
    }
    return result;
}

// void union_arrays(int* dest, int* arr1, int* arr2, int length) {
//     for (int i = 0; i < length; i++) {
//         dest[i] = arr1[i] | arr2[i];
//     }
// }

int* intersection_rows(int* row1, int* row2, int length) {
    int* result = (int*) malloc(length * sizeof(int));
    for (int i = 0; i < length; i++) {
        result[i] = row1[i] & row2[i];
    }
    return result;
}


int* intersection_arrays(int* arr1, int* arr2, int len1, int len2, int* out_len) {
    int* result = (int*) malloc(len1 * sizeof(int));
    int count = 0;
    for (int i = 0; i < len1; i++) {
        for (int j = 0; j < len2; j++) {
            if (arr1[i] == arr2[j]) {
                result[count++] = arr1[i];
                break;
            }
        }
    }
    *out_len = count;
    return result;
}


// EC and explore

COV EC(Matrix A, int** B, COV* cov) {
    int N = A.rows;
    int M = A.cols;
    // COV cov = create_cov();

    for (int i = 0; i < N; i++) {
        int sum = 0;
        for (int x = 0; x < M; x++) {
            sum += A.data[i][x];
        }
        
        if (sum == 0) break;
        if (sum == M) {
            int* temp_set = (int*)malloc(sizeof(int));
            temp_set[0] = i;
            add_to_cov(&cov, temp_set, 1);
            free(temp_set);
            break;
        }

        for (int j = 0; j < i; j++) {
            if (intersect(&A.data[j * M], &A.data[i * M], M)) {
                B[j][i] = 0;
            } else {
                int I[2] = {i, j};
                int* U = (int*)malloc(M * sizeof(int));
                // union_arrays(U, &A.data[i * M], &A.data[j * M], M);
                U = union_arrays(&A.data[i * M], &A.data[j * M], M);

                sum = 0;
                for (int x = 0; x < M; x++) {
                    sum += U[x];
                }

                if (sum == M) {
                    int* temp_set = (int*)malloc(2 * sizeof(int));
                    temp_set[0] = i < j ? i : j;
                    temp_set[1] = i > j ? i : j;
                    add_to_cov(&cov, temp_set, 2);
                    free(temp_set);
                    B[j][i] = 1;
                } else {
                    B[j][i] = 1;
                    int inter_count = 0;
                    for (int k = 0; k < j; k++) {
                        if (B[k][i] && B[k][j]) {
                            inter_count++;
                        }
                    }
                    int* inter = (int*)malloc(inter_count * sizeof(int));
                    int idx = 0;
                    for (int k = 0; k < j; k++) {
                        if (B[k][i] && B[k][j]) {
                            inter[idx++] = k;
                        }
                    }
                    if (idx > 0) {
                        explore(I, 2, U, &cov, A, B);
                    }
                    free(inter);
                }
                free(U);
            }
        }
    }

    return cov;
}

void explore(int* I, int I_length, int* U, COV* cov, Matrix A, int** B) {
    int N = A.cols;
    
    // Instead of using list comprehension, we'll loop through `inter` manually
    for (int idx = 0; idx < I_length; idx++) {
        int k = I[idx];
        
        // Create i_temp by adding k to I
        int i_temp_length = I_length + 1;
        int* i_temp = (int*) malloc(i_temp_length * sizeof(int));
        memcpy(i_temp, I, I_length * sizeof(int));
        i_temp[I_length] = k;
        
        // Create u_temp by union of U and the kth row of A.data
        // int* u_temp = union_rows(U, &A.data[k * N], N);
        int* u_temp = union_arrays(U, &A.data[k * N], N);
        
        int u_sum = 0;
        for (int j = 0; j < N; j++) {
            u_sum += u_temp[j];
        }
        
        if (u_sum == N) {
            // Add i_temp to COV
            add_to_cov(cov, i_temp, i_temp_length);
        } else {
            // Compute inter_temp
            int* inter_temp = (int*) malloc(I_length * sizeof(int));
            int inter_temp_length = 0;
            for (int l = 0; l < I_length; l++) {
                if (I[l] < k && B[I[l]][k]) {
                    inter_temp[inter_temp_length++] = I[l];
                }
            }
            
            // Recursion
            if (inter_temp_length > 0) {
                explore(i_temp, i_temp_length, u_temp, cov, A, B);
            }
            
            free(inter_temp);
        }
        
        free(i_temp);
        free(u_temp);
    }
}


// Incremental process
void incremental_process(Matrix A, DynamicArray* B[], COV* cov) {
    int N = A.rows;
    
    // Extend B to accommodate the new rows
    for (int i = 0; i < A.rows; i++) {
        for (int j = 0; j < N; j++) {
            if (intersect(&A.data[i * A.cols], &A.data[j * A.cols], A.cols)) {
                append(&B[j], 0);
            } else {
                append(&B[j], 1);
            }
        }
    }

    // Extend B for the new rows relative to themselves
    for (int i = 0; i < A.rows; i++) {
        int zeros[A.rows - i];
        for (int j = 0; j < A.rows - i; j++) {
            zeros[j] = 0;
        }
        extend(&B[i], zeros, A.rows - i);
    }

    // Update COV if needed
    for (int i = 0; i < A.rows; i++) {
        int sum = 0;
        for (int j = 0; j < A.cols; j++) {
            sum += A.data[i][j];
        }
        if (sum == A.cols) {
            add_cov(&cov, N + i);
        }
    }
}


// Main

int main() {
    const char* filename = "ec_instance.txt";
    const int mem_size = 1024 * 1024;  // 1 MB

    int comment_lines = count_comment_lines(filename);
    int n_columns = detect_columns(filename, comment_lines);

    int loadable_rows = mem_size / n_columns;  // each entry is 1 byte (as char)
    int offset = comment_lines;

    // Load the initial chunk
    Matrix initial_matrix = read_file(filename, loadable_rows, n_columns, offset);
    offset += initial_matrix.rows;
    DynamicArray** B = malloc(initial_matrix.rows * sizeof(DynamicArray*));
    for (int i = 0; i < initial_matrix.rows; i++) {
        B[i] = malloc(sizeof(DynamicArray));
        init_array(B[i], initial_matrix.rows);
        for (int j = 0; j < initial_matrix.rows; j++) {
            append(B[i], 0);
        }
    }

    COV cov = create_cov();

    EC(initial_matrix, B, &cov);

    // Process subsequent chunks incrementally
    while (true) {
        Matrix matrix = read_file(filename, loadable_rows, n_columns, offset);
        if (matrix.rows == 0) {
            free(matrix.data);
            break;
        }

        incremental_process(matrix, B);
        offset += matrix.rows;
        free(matrix.data);
    }

    printf("Solutions:\n");

    // Print solutions
    print_cov(&cov);

    // Cleanup
    for (int i = 0; i < initial_matrix.rows; i++) {
        free(B[i]->data);
        free(B[i]);
    }
    free(B);
    free(initial_matrix.data);

    return 0;
}
