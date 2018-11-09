# Create demos and tests targets
add_demos_project()
add_tests_project()

# Demo project uses heap_5
target_sources(
    aws_demos PRIVATE
    "${lib_dir}/FreeRTOS/portable/MemMang/heap_5.c"
)

# Test project uses heap_4
target_sources(
    aws_tests PRIVATE
    "${lib_dir}/FreeRTOS/portable/MemMang/heap_4.c"
)
