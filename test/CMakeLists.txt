function(create_test path lib)
  get_filename_component(target ${path} NAME_WE)
  set(target "${target}_${lib}")

  cuda_add_executable(${target} ${path})
  target_link_libraries(${target} ${lib})

  add_test(NAME ${target} COMMAND $<TARGET_FILE:${target}>)
  file(RELATIVE_PATH rpath ${CMAKE_SOURCE_DIR} ${path})
  set_property(TEST ${target} APPEND PROPERTY LABELS "${rpath} (${lib})")
endfunction()

function(add_test_dir dir)
  file(GLOB test_sources ${dir}/*.cpp)

  foreach(path IN LISTS test_sources)
    create_test(${path} "${dir}_${cpulib}")
    create_test(${path} "${dir}_${gpulib}")
  endforeach()
endfunction()

add_test_dir(thrust)
add_test_dir(a)