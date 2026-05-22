# Matrix-Multiplication-CPU-VS-GPU

A high-performance comparison between sequential CPU execution and parallelized GPU execution using **C** and **NVIDIA CUDA**. This project demonstrates the massive throughput capabilities of GPUs when handling large-scale linear algebra operations.

## 🚀 The Result
After correcting for initial timing unit mismatches (CPU seconds vs. GPU milliseconds), the results were definitive:
* **Up to 1000x Speedup** on matrix sizes of $1024 \times 1024$ and larger.
* **Efficiency at Scale:** While the CPU is competitive for tiny matrices due to low overhead, the GPU scales exponentially better as the workload increases.

## 🧠 Project Overview
Matrix multiplication is the backbone of modern AI and Graphics. This project explores the "Naive" implementation of the algorithm to establish a baseline for hardware performance.

### Core Objectives:
* **Parallelization:** Offloading nested-loop computations from a single-threaded CPU to thousands of concurrent GPU threads.
* **Performance Analysis:** Benchmarking execution time across varying matrix dimensions ($N$).
* **Unit Rigor:** Ensuring precise measurement by accounting for host-to-device data transfer times and proper time-unit synchronization.

## 🛠️ Tech Stack
* **Language:** C 
* **Parallel Computing:** NVIDIA CUDA 
* **Hardware Tested:** NVIDIA T4 GPU 
* **Tools:** `nvcc` compiler, `std::chrono` for high-resolution timing.

## 📊 Benchmarks
The following table highlights the execution time gap as the matrix size ($N \times N$) grows:

| Matrix Size (N) | CPU Time (ms) | GPU Time (ms) | Speedup |
| :--- | :--- | :--- | :--- |
| 128 | ~2 | ~0.5 | 4x |
| 512 | ~150 | ~1.2 | 125x |
| 1024 | ~1200 | ~2.5 | 480x |
| 2048 | ~9500 | ~9.5 | **1000x** |

> **Note:** The CPU performance drops off significantly at larger scales due to the $O(N^3)$ complexity, while the GPU maintains high throughput by saturating its Streaming Multiprocessors.

## 💻 How to Run
1. **Clone the repo:**
   ```bash
   git clone [https://github.com/lbm-realty/Matrix-Multiplication-CPU-VS-GPU.git](https://github.com/lbm-realty/Matrix-Multiplication-CPU-VS-GPU.git)
   ```
2. **Compile the CUDA code:**
    ```bash
    nvcc -o matmul matrix_mul.cu
    ```
3. **Execute:**
  ```bash
  ./matmul
  ```

## 📈 Key Learnings

  - PCIe Bottlenecks: Realized that for small matrices, the time spent moving data over the PCIe bus is longer than the computation itself.  
  - Grid/Block Heuristics: Learned how to map 2D data structures to CUDA's threadIdx and blockIdx architecture.
