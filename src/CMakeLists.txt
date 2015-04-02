function(add_src_dir dir)
  file(GLOB sources ${dir}/*.cpp)

  foreach(path IN LISTS sources)
    add_library("${dir}_${cpulib}" STATIC ${path})
  endforeach()

  file(GLOB cusources ${dir}/*.cu)

  foreach(path IN LISTS cusources)
    cuda_add_library("${dir}_${gpulib}" STATIC ${path})
  endforeach()
endfunction()

add_src_dir(thrust)
add_src_dir(a)