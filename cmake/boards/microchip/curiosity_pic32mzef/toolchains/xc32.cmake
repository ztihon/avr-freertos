# -------------------------------------------------------------------------------------------------
# Common settings
# -------------------------------------------------------------------------------------------------
# Set output extension to .elf
set(CMAKE_EXECUTABLE_SUFFIX .elf)

# FreeRTOS portable layer code
target_sources(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/MPLAB/PIC32MZ/ISR_Support.h"
    "${lib_dir}/FreeRTOS/portable/MPLAB/PIC32MZ/port.c"
    "${lib_dir}/FreeRTOS/portable/MPLAB/PIC32MZ/port_asm.S"
    "${lib_dir}/FreeRTOS/portable/MPLAB/PIC32MZ/portmacro.h"
)
target_include_directories(
    afr_lib_kernel INTERFACE
    "${lib_dir}/FreeRTOS/portable/MPLAB/PIC32MZ"
)
target_include_directories(
    afr_lib_kernel_plus_tcp INTERFACE
    "${lib_dir}/FreeRTOS-Plus-TCP/source/portable/Compiler/GCC"
)

# Do not add defines to assembler
set(CMAKE_ASM_COMPILE_OBJECT "<CMAKE_ASM_COMPILER> <FLAGS> <INCLUDES> -o <OBJECT> -c <SOURCE>")

foreach(target_name IN ITEMS aws_demos aws_tests)
    # Preprocessor macros
    target_compile_definitions(
        ${target_name} PRIVATE
        XPRJ_pic32mz_ef_curiosity=pic32mz_ef_curiosity
    )

    # Compiler and linker options
    set(common_flags "-mprocessor=32MZ2048EFM100" "-no-legacy-libc" "-mnewlib-libc")
    set(c_flags "-std=gnu99" "-fgnu89-inline" "-ffunction-sections")
    set(asm_flags "-Wa,--defsym=__MPLAB_BUILD=1,--gdwarf-2")
    set(linker_flags "-Wl,--defsym=__MPLAB_BUILD=1,--defsym=_min_heap_size=170000,--defsym=_min_stack_size=10000,--gc-sections,--no-code-in-dinit,--no-dinit-in-serial-mem")

    target_compile_options(
        ${target_name} PRIVATE
        $<$<COMPILE_LANGUAGE:C>:${common_flags} ${c_flags}>
    )
    target_compile_options(
        ${target_name} PRIVATE
        $<$<COMPILE_LANGUAGE:ASM>:${common_flags} ${asm_flags}>
    )
    target_link_libraries(
        ${target_name} PRIVATE
        ${common_flags}
        ${linker_flags}
        "${3rdparty_mcu_microchip_dir}/bin/framework/peripheral/PIC32MZ2048EFM100_peripherals.a"
    )

    # Post build commands
    add_custom_command(
        TARGET ${target_name} POST_BUILD
        COMMAND ${XC32_BIN}/xc32-bin2hex "$<TARGET_FILE:${target_name}>"
    )
endforeach()

# -------------------------------------------------------------------------------------------------
# Project specific settings
# -------------------------------------------------------------------------------------------------
# Linker script
# TODO, below requires bootloader project
# target_link_libraries(
#     aws_demos PRIVATE
#     "-Wl,--script=\"${demos_board_prefix}/application_code/microchip_code/app_mz.ld\""
# )

# target_link_libraries(
#     aws_tests PRIVATE
#     "-Wl,--script=\"${tests_board_prefix}/application_code/microchip_code/app_mz.ld\""
# )
