cmake_minimum_required(VERSION 3.12)

project(
    Amazon_FreeRTOS
    VERSION 1.4.1
    LANGUAGES C
)

if("${CMAKE_SYSTEM_NAME}" STREQUAL "Generic")
    enable_language(ASM)
endif()

include("cmake/utilities.cmake")

# Use C99 by default. This only works if CMake support setting standard on selected compiler.
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

# In-source build is not allowed.
if("${PROJECT_SOURCE_DIR}" STREQUAL "${PROJECT_BINARY_DIR}")
    message(FATAL_ERROR "In-source build is not allowed. Please make a separate build folder, e.g. {ROOT}/build.")
endif()

# -------------------------------------------------------------------------------------------------
# Configure target board
# -------------------------------------------------------------------------------------------------
set(
    TARGET_BOARD "pc.windows"
    CACHE STRING
    "Target board chosen by the user at configure time"
)

# Get list of supported boards.
file(GLOB vendors "cmake/boards/*")
foreach(vendor IN LISTS vendors)
    file(GLOB boards "${vendor}/*")
    foreach(board_path IN LISTS boards)
        get_filename_component(vendor "${board_path}" DIRECTORY)
        get_filename_component(vendor "${vendor}" NAME)
        get_filename_component(board "${board_path}" NAME)
        list(APPEND board_values "${vendor}.${board}")
    endforeach()
endforeach()

set_property(CACHE TARGET_BOARD PROPERTY STRINGS ${board_values})
string(REGEX MATCH [[(.+)\.(.+)]] match_result ${TARGET_BOARD})
set(vendor ${CMAKE_MATCH_1})
set(board ${CMAKE_MATCH_2})

# Abort if the target board is not supported, i.e., corresponding folder is not present.
if(NOT TARGET_BOARD IN_LIST board_values)
    message(FATAL_ERROR "Board is not supported: ${TARGET_BOARD}")
else()
    message(STATUS "Target board: ${TARGET_BOARD}")
endif()

# Set board_dir to "vendor/board", portable_dir to "portable/vendor/board".
set(board_dir "${vendor}/${board}")
set(portable_dir "portable/${board_dir}")

# -------------------------------------------------------------------------------------------------
# Determine toolchain
# -------------------------------------------------------------------------------------------------
# If we're cross compiling to a board, set "toolchain" to the file name of CMAKE_TOOLCHAIN_FILE,
# otherwise, set it to compiler id in lower case.
if(CMAKE_TOOLCHAIN_FILE)
    get_filename_component(toolchain "${CMAKE_TOOLCHAIN_FILE}" NAME)
elseif("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
    set(toolchain "gcc.cmake")
else()
    set(toolchain "${CMAKE_C_COMPILER_ID}.cmake")
    string(TOLOWER "${toolchain}" toolchain)
endif()
message(STATUS "Toolchain: ${toolchain}")

# -------------------------------------------------------------------------------------------------
# Include libraries, demos and tests targets
# -------------------------------------------------------------------------------------------------
set(lib_dir "${CMAKE_SOURCE_DIR}/lib")
set(demos_dir "${CMAKE_SOURCE_DIR}/demos/common")
set(tests_dir "${CMAKE_SOURCE_DIR}/tests/common")
set(3rdparty_dir "${CMAKE_SOURCE_DIR}/lib/third_party")
get_filename_component(demos_board_prefix "${demos_dir}/../${board_dir}/common" REALPATH)
get_filename_component(tests_board_prefix "${tests_dir}/../${board_dir}/common" REALPATH)

# Import override control variables into current scope.
include("cmake/boards/${board_dir}/override.cmake" OPTIONAL)

add_subdirectory("lib")
add_subdirectory("demos")
add_subdirectory("tests")

# -------------------------------------------------------------------------------------------------
# Projects setup
# -------------------------------------------------------------------------------------------------
# Driver code
include("cmake/boards/${board_dir}/driver.cmake")

# Setup projects
include("cmake/boards/${board_dir}/projects.cmake")

# Import compiler settings
include("cmake/boards/${board_dir}/toolchains/${toolchain}")
