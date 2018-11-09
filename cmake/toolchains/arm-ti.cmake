include("cmake/utilities.cmake")

set(CMAKE_SYSTEM_NAME Generic)

# Find TI for ARM.
find_compiler(TI_ARM_CL armcl)

# Specify the cross compiler.
set(CMAKE_C_COMPILER ${TI_ARM_CL})
set(CMAKE_CXX_COMPILER ${TI_ARM_CL})
set(CMAKE_ASM_COMPILER ${TI_ARM_CL})

# Disable compiler checks.
set(CMAKE_C_COMPILER_FORCED TRUE)
set(CMAKE_CXX_COMPILER_FORCED TRUE)

# Add target system root to cmake find path.
get_filename_component(TI_ARM_BIN "${TI_ARM_CL}" DIRECTORY)
get_filename_component(CMAKE_FIND_ROOT_PATH "${TI_ARM_BIN}" DIRECTORY)

# Don't look for executable in target system prefix.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Look for includes, libraries and packages in the target system prefix.
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Set up TI compiler default flags and lib settings.
set(CMAKE_C_FLAGS_INIT "--c99")
set(CMAKE_C_FLAGS_DEBUG_INIT "-g")
link_directories(${CMAKE_FIND_ROOT_PATH}/lib)
link_libraries(-llibc.a)

# TI linker does not recognize response file.
set(CMAKE_C_USE_RESPONSE_FILE_FOR_OBJECTS OFF)
