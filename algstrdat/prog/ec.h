#ifndef EC_H
#define EC_H

#include "reader.h"

typedef struct {
    char **data;   // Array of arrays to store the COV matrix
    int rows;      // Number of partitions found
    int cols;      // Number of sets
} CovMatrix;

CovMatrix* exact_cover(Matrix* A);
void free_cov(CovMatrix* cov);
void write_partitions_to_file(CovMatrix* cov, const char* filename, int iterations);

#endif /* EC_H */
