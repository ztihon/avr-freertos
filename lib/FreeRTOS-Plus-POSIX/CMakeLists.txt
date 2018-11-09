add_library(afr_lib_kernel_plus_posix INTERFACE)
get_source_files(sources DIRECTORY "source")
get_source_files(headers DIRECTORY "include")
target_sources(
    afr_lib_kernel_plus_posix INTERFACE
    ${sources}
    ${headers}
)
target_include_directories(
    afr_lib_kernel_plus_posix INTERFACE
    "${lib_dir}/FreeRTOS-Plus-POSIX/include"
    "${lib_dir}/FreeRTOS-Plus-POSIX/include/${portable_dir}"
)
