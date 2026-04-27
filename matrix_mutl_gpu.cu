#include <stdio.h>

int SIZE = 20;

__global__ void matrix_multiplication_kernel(float *a, float *b, float *c, int N) {
  int row = blockIdx.y  * blockDim.y + threadIdx.y;
  int col = blockIdx.x  * blockDim.x + threadIdx.x;

  if (row < N && col < N) {
      float sum = 0.0;

      for (int i = 0; i < N; i++)
        sum += a[row * N + i] * b[i * N + col];
      c[row * N + col] = sum;
  }
}

void allocating_data(float *h_a, float *h_b, float *h_c, int N) {
  float *d_a = nullptr, *d_b = nullptr, *d_c = nullptr;

  cudaMalloc(&d_a, N * N * sizeof(float));
  cudaMalloc(&d_b, N * N * sizeof(float));
  cudaMalloc(&d_c, N * N * sizeof(float));

  cudaMemcpy(d_a, h_a, N * N * sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, h_b, N * N * sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_c, h_c, N * N * sizeof(float), cudaMemcpyHostToDevice);

  int blockSize = 16;
  dim3 threadsPerBlock(blockSize, blockSize);
  dim3 blocksPerGrid((N + blockSize - 1) / blockSize,(N + blockSize - 1) / blockSize);

  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);

  cudaEventRecord(start);
  matrix_multiplication_kernel<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_b, d_c, N);
  cudaEventRecord(stop);

  cudaEventSynchronize(stop);
  cudaMemcpy(h_c, d_c, N * N * sizeof(float), cudaMemcpyDeviceToHost);

  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  float milliseconds = 0;
  cudaEventElapsedTime(&milliseconds, start, stop);
  printf("GPU Time: %f ms\n", milliseconds / 1000);

/*
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      printf("%.2f ", h_c[i * N + j]);
    }
    printf("\n");
  }
*/

}

int main() {
  int N = 1024;
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

  allocating_data(&mat_a[0], &mat_b[0], &mat_c[0], N);

  free(mat_a);
  free(mat_b);
  free(mat_c);

  return 0;
}
