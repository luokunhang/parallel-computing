#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

#include <thrust/copy.h>
#include <thrust/fill.h>
#include <thrust/sequence.h>

#include "Timer.hpp"
#include <iostream>
#include <string>
#include <cmath>
#include <random>


template <typename VectorType, typename T>
void randomize(VectorType &x, T scale) {
  std::default_random_engine generator;
  std::uniform_real_distribution<double> distribution(-scale, scale);
  static auto dice = std::bind(distribution, generator);

  for (size_t i = 0; i < x.size(); ++i) {
    x[i] = dice();
  }
}


int main(int argc, char* argv[]) {

  size_t exponent           = 27;
  size_t num_trips          = 1;

  if (argc >= 2) exponent   = std::stol(argv[1]);
  if (argc >= 3) num_trips  = std::stol(argv[2]);

  size_t num_elements = 1 << exponent;
  
  thrust::host_vector<float> x(num_elements);
  randomize(x, 10.0f);
  thrust::device_vector<float> X(num_elements);
  thrust::copy(x.begin(), x.end(), X.begin());

  DEF_TIMER(gpu_norm_lambda);
  START_TIMER(gpu_norm_lambda);

  float                init = 0.0;
  thrust::plus<float>  binary_op;

  cudaDeviceSynchronize();
  for (size_t i = 0; i < num_trips; ++i) {
    /* write me -- use thrust::transform_reduct and a lambda for one or both of the unary op and binary op */
    thrust::transform_reduce(X.begin(), X.end(), []__host__ __device__(const float x) -> float {
      return x * x;
    }, init, binary_op);
    cudaDeviceSynchronize();
  }
  double cuda_time = STOP_TIMER_QUIETLY(gpu_norm_lambda);

  std::cout << exponent << "\t" << num_trips << "\t" << cuda_time << std::endl;

  return 0;
}
