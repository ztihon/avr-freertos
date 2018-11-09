# Core lib target, must be linked first for AFR projects.
add_library(afr_lib_core INTERFACE)
target_link_libraries(
    afr_lib_core INTERFACE
    afr_lib_kernel
    afr_lib_utils
)

# Core lib dependencies
if(NOT override_lib_core)
    target_link_libraries(
        afr_lib_core INTERFACE
        afr_lib_wifi
        afr_demo_logging
        afr_demo_key_provisioning
    )
endif()

# -------------------------------------------------------------------------------------------------
# Libraries
# -------------------------------------------------------------------------------------------------
# Find and add all modules.
file(GLOB afr_modules "${CMAKE_CURRENT_LIST_DIR}/*")
foreach(module IN LISTS afr_modules)
    if(IS_DIRECTORY "${module}" AND EXISTS "${module}/CMakeLists.txt")
        add_subdirectory("${module}")
    endif()
endforeach()

# Add additional configurations if exists.
include("${PROJECT_SOURCE_DIR}/cmake/boards/${board_dir}/lib.cmake" OPTIONAL)
