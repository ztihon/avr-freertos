# Create demos and tests targets
add_demos_project()
add_tests_project()

# Add linker file to sources
foreach(type IN ITEMS demos tests)
    target_sources(
        aws_${type} PRIVATE
        "${${type}_board_prefix}/application_code/ti_code/CC3220SF_LAUNCHXL_FREERTOS.cmd"
    )
endforeach()
