# Microchip doesn't support key provisioning.
target_link_libraries(
    afr_lib_core INTERFACE
    afr_lib_wifi
    afr_demo_logging
    # afr_demo_key_provisioning
)
# Microchip uses FreeRTOS+TCP
target_sources(
    afr_lib_kernel_plus_tcp INTERFACE
    "${lib_dir}/FreeRTOS-Plus-TCP/source/portable/NetworkInterface/pic32mzef/NetworkInterface_eth.c"
    "${lib_dir}/FreeRTOS-Plus-TCP/source/portable/NetworkInterface/pic32mzef/NetworkInterface_wifi.c"
    "${lib_dir}/FreeRTOS-Plus-TCP/source/portable/NetworkInterface/pic32mzef/BufferAllocation_2.c"
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
