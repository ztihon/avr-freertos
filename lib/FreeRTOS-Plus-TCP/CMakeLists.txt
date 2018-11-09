add_library(afr_lib_kernel_plus_tcp INTERFACE)
get_source_files(sources DIRECTORY "source")
get_source_files(headers DIRECTORY "include")
target_sources(
    afr_lib_kernel_plus_tcp INTERFACE
    ${sources}
    ${headers}
)
target_include_directories(
    afr_lib_kernel_plus_tcp INTERFACE
    "${lib_dir}/FreeRTOS-Plus-TCP/include"
)
