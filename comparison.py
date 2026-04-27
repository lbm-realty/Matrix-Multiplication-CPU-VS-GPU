import subprocess
import matplotlib.pyplot as plt

# Define the matrix sizes you want to test
sizes = [128, 256, 512, 1024, 2048]
cpu_results = []
gpu_results = []

for n in sizes:
    print(f"Benchmarking N={n}...")
    
    # Run CPU binary: pass 'n' as a command line argument
    cpu_time = subprocess.check_output(['./matrix_mult_cpu', str(n)])
    cpu_results.append(float(cpu_time))
    
    # Run GPU binary: pass 'n' as a command line argument
    gpu_time = subprocess.check_output(['./matrix_mult_gpu', str(n)])
    gpu_results.append(float(gpu_time))

# Plotting the results
plt.figure(figsize=(6, 4))
plt.plot(sizes, cpu_results, label='CPU (Naive)', marker='o')
plt.plot(sizes, gpu_results, label='GPU (Naive)', marker='s')

plt.xlabel('Matrix Size (N)')
plt.ylabel('Time (ms)')
plt.title('CPU vs GPU Matrix Multiplication Performance')
plt.legend()
plt.grid(True)
# Use log scale if CPU time dwarfs GPU time significantly
plt.yscale('log') 
plt.show()