include("cmake/utilities.cmake")

set(CMAKE_SYSTEM_NAME Generic)

# Find Microchip XC32.
find_compiler(XC32_C xc32-gcc)
find_compiler(XC32_CXX xc32-g++)

# Specify the cross compiler.
set(CMAKE_C_COMPILER ${XC32_C})
set(CMAKE_CXX_COMPILER ${XC32_CXX})
set(CMAKE_ASM_COMPILER ${XC32_C})

# Disable compiler checks.
set(CMAKE_C_COMPILER_FORCED TRUE)
set(CMAKE_CXX_COMPILER_FORCED TRUE)

# Add target system root to cmake find path.
get_filename_component(XC32_BIN "${XC32_C}" DIRECTORY)
get_filename_component(CMAKE_FIND_ROOT_PATH "${XC32_BIN}" DIRECTORY)

# Don't look for executable in target system prefix.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Look for includes, libraries and packages in the target system prefix.
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
