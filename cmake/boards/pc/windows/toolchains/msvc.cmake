# -------------------------------------------------------------------------------------------------
# Common settings
# -------------------------------------------------------------------------------------------------
foreach(target_name IN ITEMS aws_demos aws_tests)
    # Compiler and linker options
    target_compile_definitions(
        ${target_name} PRIVATE
        _CRT_SECURE_NO_WARNINGS
    )

    target_compile_options(
        ${target_name} PRIVATE
        "/MP" "/W4" "/wd4210" "/wd4127" "/wd4244" "/wd4310"
    )

    # Post build commands
    add_custom_command(
        TARGET ${target_name} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${target_name}> ${CMAKE_BINARY_DIR}
    )
endforeach()
