# NXP LPC54018 driver code
add_library(3rdparty_mcu_nxp INTERFACE)
set(3rdparty_mcu_nxp_dir "${3rdparty_dir}/mcu_vendor/nxp/LPC54018")
get_source_files(3rdparty_mcu_nxp_drivers_src DIRECTORY "${3rdparty_mcu_nxp_dir}/drivers" EXTENSIONS "h")
list(
    APPEND 3rdparty_mcu_nxp_drivers_src
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_adc.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_clock.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_common.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_crc.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_ctimer.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_dma.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_dmic.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_dmic_dma.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_emc.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_enet.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_flexcomm.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_gpio.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_i2c.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_i2s.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_inputmux.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_pint.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_power.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_reset.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_spi.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_spi_dma.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_spifi.c"
    "${3rdparty_mcu_nxp_dir}/drivers/fsl_usart.c"
    "${3rdparty_mcu_nxp_dir}/drivers/mflash_drv.c"
    "${3rdparty_mcu_nxp_dir}/drivers/mflash_file.c"
)
get_source_files(3rdparty_mcu_nxp_middleware_usb_src DIRECTORY "${3rdparty_mcu_nxp_dir}/middleware/usb" EXTENSIONS "h" RECURSE)
list(
    APPEND 3rdparty_mcu_nxp_middleware_usb_src
    "${3rdparty_mcu_nxp_dir}/middleware/usb/osa/usb_osa_freertos.c"
    "${3rdparty_mcu_nxp_dir}/middleware/usb/device/usb_device_dci.c"
    "${3rdparty_mcu_nxp_dir}/middleware/usb/device/usb_device_lpcip3511.c"
)
get_source_files(3rdparty_mcu_nxp_middleware_wifi_src DIRECTORY "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca" RECURSE)
set(
    3rdparty_mcu_nxp_startup_src
    "${3rdparty_mcu_nxp_dir}/iar/startup_LPC54018.s"
    "${3rdparty_mcu_nxp_dir}/system_LPC54018.c"
    "${3rdparty_mcu_nxp_dir}/system_LPC54018.h"
)
set(
    3rdparty_mcu_nxp_utilities_src
    "${3rdparty_mcu_nxp_dir}/utilities/io/fsl_io.c"
    "${3rdparty_mcu_nxp_dir}/utilities/io/fsl_io.h"
    "${3rdparty_mcu_nxp_dir}/utilities/log/fsl_log.c"
    "${3rdparty_mcu_nxp_dir}/utilities/str/fsl_str.c"
    "${3rdparty_mcu_nxp_dir}/utilities/str/fsl_str.h"
    "${3rdparty_mcu_nxp_dir}/utilities/fsl_assert.c"
    "${3rdparty_mcu_nxp_dir}/utilities/fsl_debug_console.c"
    "${3rdparty_mcu_nxp_dir}/utilities/fsl_debug_console.h"
    "${3rdparty_mcu_nxp_dir}/utilities/fsl_debug_console_conf.h"
    "${3rdparty_mcu_nxp_dir}/utilities/usb_device_cdc_acm.c"
    "${3rdparty_mcu_nxp_dir}/utilities/usb_device_cdc_acm.h"
    "${3rdparty_mcu_nxp_dir}/utilities/usb_device_ch9.c"
    "${3rdparty_mcu_nxp_dir}/utilities/usb_device_ch9.h"
    "${3rdparty_mcu_nxp_dir}/utilities/usb_device_config.h"
    "${3rdparty_mcu_nxp_dir}/utilities/usb_device_descriptor.c"
    "${3rdparty_mcu_nxp_dir}/utilities/usb_device_descriptor.h"
    "${3rdparty_mcu_nxp_dir}/utilities/virtual_com.c"
    "${3rdparty_mcu_nxp_dir}/utilities/virtual_com.h"
)
target_sources(
    3rdparty_mcu_nxp INTERFACE
    ${3rdparty_mcu_nxp_drivers_src}
    ${3rdparty_mcu_nxp_middleware_usb_src}
    ${3rdparty_mcu_nxp_middleware_wifi_src}
    ${3rdparty_mcu_nxp_startup_src}
    ${3rdparty_mcu_nxp_utilities_src}
)
target_include_directories(
    3rdparty_mcu_nxp INTERFACE
    "${3rdparty_mcu_nxp_dir}"
    "${3rdparty_mcu_nxp_dir}/drivers"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/common_src/hcd"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/common_src/include"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/common_src/stack_common"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/common_src/wmi"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/custom_src/include"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/custom_src/stack_custom"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/include"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/include/AR6002"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/include/AR6002/hw2.0/hw"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/port"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/port/boards/clickbrd_tread/freertos"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/port/boards/clickbrd_tread/freertos/gt202"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/port/drivers/flexcomm_freertos"
    "${3rdparty_mcu_nxp_dir}/middleware/wifi_qca/port/env/freertos"
    "${3rdparty_mcu_nxp_dir}/middleware/usb/device"
    "${3rdparty_mcu_nxp_dir}/middleware/usb/include"
    "${3rdparty_mcu_nxp_dir}/middleware/usb/osa"
    "${3rdparty_mcu_nxp_dir}/utilities"
    "${3rdparty_mcu_nxp_dir}/utilities/io"
    "${3rdparty_mcu_nxp_dir}/utilities/log"
    "${3rdparty_mcu_nxp_dir}/utilities/str"
)
target_link_libraries(
    3rdparty_mcu INTERFACE
    3rdparty_mcu_nxp
)
