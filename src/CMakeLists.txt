file(GLOB sources *.cpp)

foreach(path IN LISTS sources)
  add_library(${cpulib} STATIC ${path})
endforeach()


file(GLOB cusources *.cu)

foreach(path IN LISTS cusources)
  cuda_add_library(${gpulib} STATIC ${path})
endforeach()
