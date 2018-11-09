# -------------------------------------------------------------------------------------------------
# Common settings
# -------------------------------------------------------------------------------------------------
# Set output extension to elf
set(CMAKE_EXECUTABLE_SUFFIX .elf)

# FreeRTOS portable layer code
target_sources(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/GCC/ARM_CM4F/port.c"
    "${lib_dir}/FreeRTOS/portable/GCC/ARM_CM4F/portmacro.h"
)
target_include_directories(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/GCC/ARM_CM4F"
)

# Do not add defines and includes to assembler
set(CMAKE_ASM_COMPILE_OBJECT "<CMAKE_ASM_COMPILER> <FLAGS> -o <OBJECT> -c <SOURCE>")

foreach(target_name IN ITEMS aws_demos aws_tests)
    # Preprocessor macros
    target_compile_definitions(
        ${target_name} PRIVATE
        USE_HAL_DRIVER
        USE_OFFLOAD_SSL
        STM32L475xx
        MQTTCLIENT_PLATFORM_HEADER=MQTTCMSIS.h
        ENABLE_IOT_INFO
        ENABLE_IOT_ERROR
        SENSOR
        RFU
    )

    # Compiler and linker options
    # -mcpu: Target CPU is ARM Cortex-M4
    # -mthumb: Targets the T32 instruction set. Default is A32, -marm .
    # -mfloat-abi=hard:  Use hardware floating-point instructions and FPU-specific calling conventions
    # -mfpu=fpv4-sp-d16: Specifies floating-point hardware
    set(common_flags "-mcpu=cortex-m4" "-mthumb" "-mfloat-abi=hard" "-mfpu=fpv4-sp-d16")
    set(c_flags "-Wall" "-fmessage-length=0" "-ffunction-sections" "-O0" "-g3")
    set(linker_flags "-specs=nosys.specs" "-z muldefs" "-Wl,-Map=output.map,--gc-sections" "-lm")

    target_compile_options(
        ${target_name} PRIVATE
        $<$<COMPILE_LANGUAGE:C>:${common_flags} ${c_flags}>
    )
    target_compile_options(
        ${target_name} PRIVATE
        $<$<COMPILE_LANGUAGE:ASM>:${common_flags}>
    )
    target_link_libraries(
        ${target_name} PRIVATE
        ${common_flags}
        ${linker_flags}
    )

    # Post build commands
    set(output_file "$<TARGET_FILE_DIR:${target_name}>/${target_name}.hex")
    add_custom_command(
        TARGET ${target_name} POST_BUILD
        COMMAND ${ARM_GCC_BIN}/arm-none-eabi-objcopy -O ihex "$<TARGET_FILE:${target_name}>" ${output_file}
        COMMAND ${ARM_GCC_BIN}/arm-none-eabi-size "$<TARGET_FILE:${target_name}>"
    )
endforeach()

# -------------------------------------------------------------------------------------------------
# Project specific settings
# -------------------------------------------------------------------------------------------------
# Linker script
target_link_libraries(
    aws_demos PRIVATE
    -T"${demos_board_prefix}/../ac6/STM32L475VGTx_FLASH.ld"
)

target_link_libraries(
    aws_tests PRIVATE
    -T"${tests_board_prefix}/../ac6/STM32L475VGTx_FLASH.ld"
)
