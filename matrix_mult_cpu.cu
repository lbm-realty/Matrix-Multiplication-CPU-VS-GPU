#include <stdio.h>
#include <chrono>

int main(int argc, char **argv) {

  if (argc != 2) {
    printf("Usage: %s <matrix_size>\n", argv[0]);
    return -1;
  }

  int N = atoi(argv[1]);
  float *mat_a, *mat_b, *mat_c;

  // Allocating memory for the matrices
  mat_a = (float *)malloc(N * N * sizeof(float));
  mat_b = (float *)malloc(N * N * sizeof(float));
  mat_c = (float *)malloc(N * N * sizeof(float));

  // Initializing the matrices
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      mat_a[i * N + j] = 1.0;
      mat_b[i * N + j] = 1.0;

      // Need to initialize matrix c to 0, if we don't, garbage values get added to result
      mat_c[i * N + j] = 0.0;
    }
  }

  auto start = std::chrono::high_resolution_clock::now();
  // Multiplying the matrices and storing the output in mat_c
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      for (int k = 0; k < N; k++) {
        mat_c[i * N + j] += mat_a[i * N + k] * mat_b[k * N + j];
      }
    }
  }

  auto end = std::chrono::high_resolution_clock::now();

  std::chrono::duration<float, std::milli> duration = end - start;
  printf("%.2f", duration.count());

 /*
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      printf("%.2f ", mat_c[i * j + N]);
    }
    printf("\n");
  }
 */

  free(mat_a);
  free(mat_b);
  free(mat_c);

  return 0;
}