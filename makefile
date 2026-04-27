# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall -Wextra -O2

# Target executable
TARGETS = matrix_mult_gpu matrix_mult_cpu

# Source files
SRC = matrix_mult_gpu.c matrix_mult_cpu.c

# Default target
all: $(TARGETS)

# Rule for the GPU version
matrix_mult_gpu: matrix_mult_gpu.c
	$(CC) $(CFLAGS) -o matrix_mult_gpu matrix_mult_gpu.c $(LDFLAGS)

# Rule for the CPU version
matrix_mult_cpu: matrix_mult_cpu.c
	$(CC) $(CFLAGS) -o matrix_mult_cpu matrix_mult_cpu.c $(LDFLAGS)

# Clean up build artifacts
clean:
	rm -f $(TARGET)

