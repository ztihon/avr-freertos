# Windows simulator doesn't have WiFi and use different logging implementation.
target_link_libraries(
    afr_lib_core INTERFACE
    # afr_lib_wifi
    # afr_demo_logging
    afr_demo_key_provisioning
)
# Windows simulator uses FreeRTOS+TCP
target_sources(
    afr_lib_kernel_plus_tcp INTERFACE
    "${lib_dir}/FreeRTOS-Plus-TCP/source/portable/BufferManagement/BufferAllocation_2.c"
    "${lib_dir}/FreeRTOS-Plus-TCP/source/portable/NetworkInterface/WinPCap/NetworkInterface.c"
)
target_include_directories(
    afr_lib_kernel_plus_tcp INTERFACE
    "${lib_dir}/FreeRTOS-Plus-TCP/source/portable/compiler/MSVC"
)

target_sources(
    afr_lib_secure_sockets INTERFACE
    "${lib_dir}/secure_sockets/portable/freertos_plus_tcp/aws_secure_sockets.c"
)
target_link_libraries(
    afr_lib_secure_sockets INTERFACE
    afr_lib_kernel_plus_tcp
    afr_lib_tls
)
