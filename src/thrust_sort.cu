#include <thrust_sort.h>

#include <thrust/sort.h>
#include <thrust/device_vector.h>
#include <thrust/copy.h>

void thrust_sort(thrust::host_vector<int>& h_vec)
{
    // transfer data to the device
    thrust::device_vector<int> d_vec = h_vec;

    // sort data with GPU
    thrust::sort(d_vec.begin(), d_vec.end());

    // transfer data back to host
    thrust::copy(d_vec.begin(), d_vec.end(), h_vec.begin());
}
