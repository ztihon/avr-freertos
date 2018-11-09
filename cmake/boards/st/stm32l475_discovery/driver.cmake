# ST STM32L475 driver code
add_library(3rdparty_mcu_st INTERFACE)
set(3rdparty_mcu_st_dir "${3rdparty_dir}/mcu_vendor/st/stm32l475_discovery")
get_source_files(3rdparty_mcu_st_src DIRECTORY "${3rdparty_mcu_st_dir}" RECURSE)
target_sources(
    3rdparty_mcu_st INTERFACE
    ${3rdparty_mcu_st_src}
)
target_include_directories(
    3rdparty_mcu_st INTERFACE
    "${3rdparty_mcu_st_dir}/BSP/B-L475E-IOT01"
    "${3rdparty_mcu_st_dir}/BSP/Components/Common"
    "${3rdparty_mcu_st_dir}/BSP/Components/es_wifi"
    "${3rdparty_mcu_st_dir}/BSP/Components/hts221"
    "${3rdparty_mcu_st_dir}/BSP/Components/lis3mdl"
    "${3rdparty_mcu_st_dir}/BSP/Components/lps22hb"
    "${3rdparty_mcu_st_dir}/BSP/Components/lsm6dsl"
    "${3rdparty_mcu_st_dir}/BSP/Components/mx25r6435f"
    "${3rdparty_mcu_st_dir}/BSP/Components/vl53l0x"
    "${3rdparty_mcu_st_dir}/CMSIS/Include"
    "${3rdparty_mcu_st_dir}/CMSIS/Device/ST/STM32L4xx/Include"
    "${3rdparty_mcu_st_dir}/STM32L4xx_HAL_Driver/Inc"
    "${3rdparty_mcu_st_dir}/STM32L4xx_HAL_Driver/Inc/Legacy"
)
target_link_libraries(
    3rdparty_mcu INTERFACE
    3rdparty_mcu_st
)
