# -------------------------------------------------------------------------------------------------
# Common settings
# -------------------------------------------------------------------------------------------------
# Set output extension to .out
set(CMAKE_EXECUTABLE_SUFFIX .out)

# FreeRTOS portable layer code
target_sources(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/CCS/ARM_CM3/port.c"
    "${lib_dir}/FreeRTOS/portable/CCS/ARM_CM3/portasm.asm"
    "${lib_dir}/FreeRTOS/portable/CCS/ARM_CM3/portmacro.h"
)
target_include_directories(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/CCS/ARM_CM3"
)

# Compiler specific driver code
target_sources(
    3rdparty_mcu_ti INTERFACE
    "${3rdparty_mcu_ti_dir}/kernel/freertos/startup/startup_cc32xx_ccs.c"
)
target_include_directories(
    3rdparty_mcu_ti INTERFACE
    ${CMAKE_FIND_ROOT_PATH}/include
)

foreach(target_name IN ITEMS aws_demos aws_tests)
    # Preprocessor macros
    target_compile_definitions(
        ${target_name} PRIVATE
        CC3220sf
    )

    # Compiler and linker options
    # C and assembler source code share same compiler options in this project
    target_compile_options(
        ${target_name} PRIVATE
        -mv7M4 --code_state=16 --float_support=vfplib -me --diag_warning=225
    )
    target_link_libraries(
        ${target_name} PRIVATE
        --heap_size=0x0 --stack_size=0x512 --diag_suppress=10063 --warn_sections --rom_model --reread_libs
        -l"${3rdparty_mcu_ti_dir}/source/ti/devices/cc32xx/driverlib/ccs/Release/driverlib.a"
        -l"${3rdparty_mcu_ti_dir}/source/ti/drivers/lib/drivers_cc32xx.aem4"
        -l"${3rdparty_mcu_ti_dir}/source/ti/drivers/net/wifi/ccs/rtos/simplelink.a"
    )
endforeach()

# -------------------------------------------------------------------------------------------------
# Project specific settings
# -------------------------------------------------------------------------------------------------
# Linker script
target_link_libraries(
    aws_demos PRIVATE
    --xml_link_info="aws_demos_linkInfo.xml"
    "${demos_board_prefix}/application_code/ti_code/CC3220SF_LAUNCHXL_FREERTOS.cmd"
)

target_link_libraries(
    aws_tests PRIVATE
    --xml_link_info="aws_tests_linkInfo.xml"
    "${tests_board_prefix}/application_code/ti_code/CC3220SF_LAUNCHXL_FREERTOS.cmd"
)
