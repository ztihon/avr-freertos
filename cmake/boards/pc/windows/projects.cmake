# FreeRTOS Windows specific code
target_sources(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/MSVC-MingW/port.c"
    "${lib_dir}/FreeRTOS/portable/MSVC-MingW/portmacro.h"
)
target_include_directories(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/MSVC-MingW"
)

# Windows simulator has a tcp server demo
add_library(
    afr_demo_tcp_server INTERFACE
)
target_sources(
    afr_demo_tcp_server INTERFACE
    "${demos_dir}/tcp/aws_simple_tcp_echo_server.c"
    "${demos_dir}/include/aws_simple_tcp_echo_server.h"
)
target_include_directories(
    afr_demo_tcp_server INTERFACE
    "${demos_dir}/include"
)
target_link_libraries(
    afr_demos INTERFACE
    afr_demo_tcp_server
)

# Additional 3rdparty for Windows
target_link_libraries(
    afr_lib_core INTERFACE
    3rdparty_tracealyzer
    3rdparty_winpcap
)

# Create demos and tests targets
add_demos_project()
add_tests_project(
    ADDITIONAL_SOURCE
    "${demos_board_prefix}/application_code/aws_demo_logging.c"
    "${demos_board_prefix}/application_code/aws_entropy_hardware_poll.c"
    ADDITIONAL_INCLUDE
    "${demos_board_prefix}/application_code"
)
