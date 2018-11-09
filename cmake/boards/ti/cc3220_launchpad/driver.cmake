# TI CC3220SF driver code
add_library(3rdparty_mcu_ti INTERFACE)
set(3rdparty_mcu_ti_dir "${3rdparty_dir}/mcu_vendor/ti/SimpleLink_CC32xx/v2_10_00_04")
target_sources(
    3rdparty_mcu_ti INTERFACE
    "${3rdparty_mcu_ti_dir}/kernel/freertos/dpl/ClockP_freertos.c"
    "${3rdparty_mcu_ti_dir}/kernel/freertos/dpl/DebugP_freertos.c"
    "${3rdparty_mcu_ti_dir}/kernel/freertos/dpl/HwiPCC32XX_freertos.c"
    "${3rdparty_mcu_ti_dir}/kernel/freertos/dpl/MutexP_freertos.c"
    "${3rdparty_mcu_ti_dir}/kernel/freertos/dpl/PowerCC32XX_freertos.c"
    "${3rdparty_mcu_ti_dir}/kernel/freertos/dpl/SemaphoreP_freertos.c"
    "${3rdparty_mcu_ti_dir}/kernel/freertos/dpl/SystemP_freertos.c"
)
target_include_directories(
    3rdparty_mcu_ti INTERFACE
    "${3rdparty_mcu_ti_dir}/source"
)
target_link_libraries(
    3rdparty_mcu INTERFACE
    3rdparty_mcu_ti
)
