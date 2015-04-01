#include <thrust_sort.h>

#include <thrust/sort.h>
#include <thrust/host_vector.h>
#include <thrust/copy.h>


void thrust_sort(thrust::host_vector<int>& h_vec)
{
    // sort data with CPU
    thrust::sort(h_vec.begin(), h_vec.end());
}
