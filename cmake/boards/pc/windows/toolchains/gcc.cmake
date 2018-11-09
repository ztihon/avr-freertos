# -------------------------------------------------------------------------------------------------
# Common settings
# -------------------------------------------------------------------------------------------------
foreach(target_name IN ITEMS aws_demos aws_tests)
    # Compiler and linker options
    target_compile_options(
        ${target_name} PRIVATE
        "-Wall" "-Wextra"
    )

    target_link_libraries(
        ${target_name} PRIVATE
        -lwinmm
    )
endforeach()
