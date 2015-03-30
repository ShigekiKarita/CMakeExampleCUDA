#include <thrust/sort.h>
#include <thrust/host_vector.h>
#include <thrust/copy.h>

#include <device.h>

void sort_on_device(thrust::host_vector<int>& h_vec)
{
    // sort data on the device
    thrust::sort(h_vec.begin(), h_vec.end());
}
