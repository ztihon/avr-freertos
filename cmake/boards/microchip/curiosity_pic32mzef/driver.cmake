# Microchip Curiosity PIC32MZEF driver code
add_library(3rdparty_mcu_microchip INTERFACE)
set(3rdparty_mcu_microchip_dir "${3rdparty_dir}/mcu_vendor/microchip/harmony/v2.05")
get_source_files(3rdparty_mcu_microchip_driver_src DIRECTORY "${3rdparty_mcu_microchip_dir}/framework/driver" EXTENSIONS "h" RECURSE)
list(
    APPEND 3rdparty_mcu_microchip_driver_src
    "${3rdparty_mcu_microchip_dir}/framework/driver/ethmac/src/dynamic/drv_ethmac.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/ethmac/src/dynamic/drv_ethmac_lib.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/ethphy/src/dynamic/drv_ethphy.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/ethphy/src/dynamic/drv_extphy_smsc8720.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/flash/src/drv_flash_static.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/miim/src/dynamic/drv_miim.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/spi/dynamic/drv_spi_api.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/spi/dynamic/drv_spi_master_dma_tasks.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/spi/dynamic/drv_spi_master_rm_tasks.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/spi/dynamic/drv_spi_tasks.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/spi/src/drv_spi_sys_queue_fifo.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/spi/src/dynamic/drv_spi.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/spi/src/dynamic/drv_spi_api.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/tmr/src/dynamic/drv_tmr.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/usart/src/dynamic/drv_usart.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/usart/src/dynamic/drv_usart_buffer_queue.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/usart/src/dynamic/drv_usart_byte_model.c"
    "${3rdparty_mcu_microchip_dir}/framework/driver/usart/src/dynamic/drv_usart_read_write.c"
)
get_source_files(3rdparty_mcu_microchip_driver_wifi_src DIRECTORY "${3rdparty_mcu_microchip_dir}/framework/driver/wifi" RECURSE)
list(
    REMOVE_ITEM 3rdparty_mcu_microchip_driver_wifi_src
    "${3rdparty_mcu_microchip_dir}/framework/driver/wifi/wilc1000/wireless_driver_extension/driver/source/m2m_ota.c"
)
get_source_files(3rdparty_mcu_microchip_osal_src DIRECTORY "${3rdparty_mcu_microchip_dir}/framework/osal" EXTENSIONS "h")
list(
    APPEND 3rdparty_mcu_microchip_osal_src
    "${3rdparty_mcu_microchip_dir}/framework/osal/src/osal.c"
    "${3rdparty_mcu_microchip_dir}/framework/osal/src/osal_freertos.c"
)
get_source_files(3rdparty_mcu_microchip_peripheral_src DIRECTORY "${3rdparty_mcu_microchip_dir}/framework/peripheral" EXTENSIONS "h" RECURSE)
list(
    APPEND 3rdparty_mcu_microchip_peripheral_src
    "${3rdparty_mcu_microchip_dir}/framework/peripheral/tmr/src/plib_tmr_pic32.c"
)
get_source_files(3rdparty_mcu_microchip_system_src DIRECTORY "${3rdparty_mcu_microchip_dir}/framework/system" EXTENSIONS "h" RECURSE)
list(
    APPEND 3rdparty_mcu_microchip_system_src
    "${3rdparty_mcu_microchip_dir}/framework/system/clk/src/sys_clk_pic32mz.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/command/src/sys_command.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/common/src/sys_buffer.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/common/src/sys_queue.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/console/src/sys_console.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/console/src/sys_console_uart.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/debug/src/sys_debug.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/devcon/src/sys_devcon.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/devcon/src/sys_devcon_cache_pic32mz.S"
    "${3rdparty_mcu_microchip_dir}/framework/system/devcon/src/sys_devcon_pic32mz.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/dma/src/sys_dma.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/int/src/sys_int_pic32.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/ports/src/sys_ports.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/ports/src/sys_ports_static.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/random/src/sys_random.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/reset/src/sys_reset.c"
    "${3rdparty_mcu_microchip_dir}/framework/system/tmr/src/sys_tmr.c"
)
get_source_files(3rdparty_mcu_microchip_tcpip_src DIRECTORY "${3rdparty_mcu_microchip_dir}/framework/tcpip" RECURSE)
get_source_files(3rdparty_mcu_microchip_bsp_src DIRECTORY "${3rdparty_mcu_microchip_dir}/bsp")
target_sources(
    3rdparty_mcu_microchip INTERFACE
    ${3rdparty_mcu_microchip_driver_src}
    ${3rdparty_mcu_microchip_driver_wifi_src}
    ${3rdparty_mcu_microchip_osal_src}
    ${3rdparty_mcu_microchip_peripheral_src}
    ${3rdparty_mcu_microchip_system_src}
    ${3rdparty_mcu_microchip_tcpip_src}
    ${3rdparty_mcu_microchip_bsp_src}
)
target_include_directories(
    3rdparty_mcu_microchip INTERFACE
    "${3rdparty_mcu_microchip_dir}/framework"
    "${3rdparty_mcu_microchip_dir}/framework/driver/wifi/wilc1000/include"
    "${3rdparty_mcu_microchip_dir}/framework/driver/wifi/wilc1000/wireless_driver/include"
    "${3rdparty_mcu_microchip_dir}/framework/driver/wifi/wilc1000/wireless_driver_extension"
    "${3rdparty_mcu_microchip_dir}/framework/driver/wifi/wilc1000/wireless_driver_extension/common/include"
    "${3rdparty_mcu_microchip_dir}/framework/driver/wifi/wilc1000/wireless_driver_extension/driver/include"
    "${3rdparty_mcu_microchip_dir}/framework/driver/wifi/wilc1000/wireless_driver_extension/driver/source"
    "${3rdparty_mcu_microchip_dir}/framework/system/common"
    "${3rdparty_mcu_microchip_dir}/bsp"
)
target_link_libraries(
    3rdparty_mcu INTERFACE
    3rdparty_mcu_microchip
)
