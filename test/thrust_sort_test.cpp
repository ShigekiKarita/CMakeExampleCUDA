#include <thrust/host_vector.h>
#include <thrust/random.h>
#include <thrust/generate.h>
#include <thrust/sort.h>
#include <cstdlib>
#include <iostream>
#include <iterator>

// defines the function prototype
#include <thrust_sort.h>

int main(void)
{
    // generate 20 random numbers on the host
    thrust::host_vector<int> h_vec(20);
    thrust::default_random_engine rng;
    thrust::generate(h_vec.begin(), h_vec.end(), rng);

    // interface to CUDA code
    thrust_sort(h_vec);
    // print sorted array
    thrust::copy(h_vec.begin(), h_vec.end(), std::ostream_iterator<int>(std::cout, "\n"));

    return 0;
}
