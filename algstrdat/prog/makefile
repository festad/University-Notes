CC=gcc
CFLAGS=-I.

DEPS = reader.h
OBJ = main.o reader.o 

%.o: %.c $(DEPS)
    $(CC) -c -o $@ $< $(CFLAGS)

main: $(OBJ)
    gcc -o $@ $^ $(CFLAGS)

clean:
    rm -f *.o main