---
title: PS7 Questions
---

### PS7 Written Questions

#### Warmup

**Q**
How many more threads are run in version 2 compared to version 1?  How much speedup might you expect?  How much speedup do you see in your plot?
Version 2 has 256 threads while version 1 has only 1, hence 255 threads more. Theoretically, I am expecting the second version to be 255 times faster. In fact, the plot shows only 35 times better performance.

#### Norm

**Q**
Use nvprof (you may use the nvprof.bash from the hello subdirectory) to analyze the three cuda/thrust programs.  Is it obvious from the output and/or the program timer output which kernel needs the most tuning, and what are the opportunities for tuning?  Describe your observations about how well cuda_norm, thrust_norm, and lambda_norm are using the GPU (occupancy, processor usage, memory bandwidth).

All three programs have the same gst_efficiency of 12.5% and gld_efficiency of 100%. CUDA has lower gst_throughout around 2.7 MB/s while thrust and lambda have about 4.2 MB/s. But CUDA has higher gls_throughout around 87.3 MB/s with that of thrust and lambda being 16.8 MB/s. CUDA has slower speed at global storing but higher speed at global loading, indicating that CUDA has a busier traffic and that explains the worse performance.

#### About PS7
**Q**
The most important thing I learned from this assignment was ...
How to interact GPU and CPU.

**Q**
One thing I am still not clear on is ...
The semantics of a pointer.