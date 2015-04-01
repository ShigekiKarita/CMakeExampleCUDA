file(GLOB test_sources *.cpp)

function(create_test path lib)
  get_filename_component(target ${path} NAME_WE)
  set(target "${target}_${lib}")
  cuda_add_executable(${target} ${path})
  target_link_libraries(${target} ${lib})

  add_test(NAME ${target} COMMAND $<TARGET_FILE:${target}>)
  set_property(TEST ${target} APPEND PROPERTY LABELS "${path} (${lib})")
endfunction()

foreach(path IN LISTS test_sources)
  create_test(${path} ${cpulib})
  create_test(${path} ${gpulib})
endforeach()