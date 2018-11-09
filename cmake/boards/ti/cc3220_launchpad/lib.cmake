# TI has TLS implementation built-into their driver.
target_sources(
    afr_lib_secure_sockets INTERFACE
    "${lib_dir}/secure_sockets/${portable_dir}/aws_secure_sockets.c"
)

# TI depends on POSIX
target_link_libraries(
    afr_lib_core INTERFACE
    afr_lib_kernel_plus_posix
    afr_lib_wifi
    afr_demo_logging
    afr_demo_key_provisioning
)
target_include_directories(
    afr_lib_kernel_plus_posix INTERFACE
    "${lib_dir}/include/FreeRTOS_POSIX"
)
