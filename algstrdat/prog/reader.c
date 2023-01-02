#include <stdio.h>
#include <stdlib.h>

#include "reader.h"

int main(void)
{
  char ROWS = 3;
  char COLS = 8;
  char *my_matrix;
  char offset = 3;

  my_matrix = read_file("dat.txt", ROWS, COLS, offset);

  // TWO WAYS TO READ THE MATRIX
  
  // 1 - WORKS
  printf(" => First way:\n");
  for(char i = 0; i < ROWS; i++)
    {
      //printf("----------------------\n");
      for(char j = 0; j < COLS; j++)
	{
	  printf("| %4d (#%2d) ", my_matrix[i*COLS + j], i*COLS + j);
	}
      printf("|\n");
    }
  //printf("----------------------\n");

  // 2 - WORKS
  printf(" => Second way:\n");
  for(char i = 0; i < ROWS*COLS; i++)
    {
      printf("| %4d (#%2d) ", my_matrix[i], i);
      if( i!=0 && ((i+1) % COLS) == 0)
	{
	  printf("|\n");
	}
    }

  free(my_matrix);

}

// offset: number of lines to skip
// from the beginning of the file
char *read_file(char *filename, int rows, int cols, int offset)
{
  printf("Reading file: %s\n", filename);
  printf("  from: line %d\n", (offset+1));
  printf("  to:   line %d\n", (offset+rows));
  printf("  (%d x %d) -> %d values\n", rows, cols, rows*cols);
  FILE *in_file = fopen(filename, "r");

  // Test for file existence
  if(in_file == NULL)
    {
      printf("Error! The file %s does not exist.\n", filename);
    }
  
  char *matrix;
  matrix = (char *)malloc(sizeof(char)*rows*cols);

  // Drop lines at the beginning
  int buffer_size = 256;
  char line[buffer_size];
  int k = 0;
  while(fgets(line, buffer_size, in_file) != NULL && ++k < offset);

  // Read integers from <filename> and put them
  // in the matrix (created as a single array
  // for memory efficiency)
  k = 0;
  int number;
  while(k < rows*cols)
    {
      if(fscanf(in_file, "%d", &number) == 1)
	{
	  matrix[k] = number;
	  k = k+1;
	}
      else
	{
	  break;
	}
    }

  fclose(in_file);
  printf("Read: %s\n", filename);
  return matrix;
  
}
