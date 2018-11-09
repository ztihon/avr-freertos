# -------------------------------------------------------------------------------------------------
# Common settings
# -------------------------------------------------------------------------------------------------
# Set output extension to .elf
set(CMAKE_EXECUTABLE_SUFFIX .elf)

# FreeRTOS portable layer code
target_sources(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/IAR/ARM_CM4F/port.c"
    "${lib_dir}/FreeRTOS/portable/IAR/ARM_CM4F/portasm.s"
)
target_include_directories(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/IAR/ARM_CM4F"
)

foreach(target_name IN ITEMS aws_demos aws_tests)
    # Preprocessor macros
    target_compile_definitions(
        ${target_name} PRIVATE
        CPU_LPC54018
        CPU_LPC54018JET180=1
        BOARD_USE_VIRTUALCOM
        USB_STACK_FREERTOS
        USB_DEVICE_CONFIG_LPCIP3511HS=1
        USB_STACK_USE_DEDICATED_RAM=1
        USE_RTOS=1
        FSL_RTOS_FREE_RTOS
        A_LITTLE_ENDIAN
    )

    # Compiler and linker options
    set(common_flags "--cpu" "Cortex-M4" "--fpu" "VFPv4_sp")
    set(
        c_flags
        "--diag_suppress" "Pa082,Pa050" "--no_cse" "--no_unroll" "--no_inline" "--no_code_motion"
        "--no_tbaa" "--no_clustering" "--no_scheduling" "--endian=little" "--use_c++_inline" "-Ol" "-e"
        "--dlib_config" "${ARM_IAR_BIN}/../INC/c/DLib_Config_Normal.h"
    )
    set(asm_flags "-s+" "-M{}" "-w-" "-j" "-DDEBUG" "-DMXL12835F")
    set(
        linker_flags
        "--redirect _Printf=_PrintfSmallNoMb" "--redirect _Scanf=_ScanfSmallNoMb"
        "--entry __iar_program_start" "--vfe" "--text_out locale"
        "--config" "${3rdparty_mcu_nxp_dir}/iar/LPC54018_ram.icf"
        "${3rdparty_mcu_nxp_dir}/iar/iar_lib_power.a"
    )

    target_compile_options(
        ${target_name} PRIVATE
        $<$<COMPILE_LANGUAGE:C>:${common_flags} ${c_flags}>
    )
    target_compile_options(
        ${target_name} PRIVATE
        $<$<COMPILE_LANGUAGE:ASM>:${common_flags} ${asm_flags}>
    )
    target_include_directories(
        ${target_name} PRIVATE
        "${ARM_IAR_BIN}/../CMSIS/Include"
    )
    target_link_libraries(
        ${target_name} PRIVATE
        ${linker_flags}
    )

    # Post build commands
    set(output_file "$<TARGET_FILE_DIR:${target_name}>/${target_name}.hex")
    add_custom_command(
        TARGET ${target_name} POST_BUILD
        COMMAND ${ARM_IAR_BIN}/ielftool --ihex "$<TARGET_FILE:${target_name}>" ${output_file}
    )
endforeach()

# -------------------------------------------------------------------------------------------------
# Project specific settings
# -------------------------------------------------------------------------------------------------
