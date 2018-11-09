# -------------------------------------------------------------------------------------------------
# Utilities
# -------------------------------------------------------------------------------------------------

# Find compiler named ${COMPILER_FILE} and store the path in variable named ${COMPILER_PATH}.
# If not found, issue a fatal message and stop processing. ${TOOLCHAIN_PATH} can be provided
# as additional search path.
function(find_compiler COMPILER_PATH COMPILER_FILE)
    # Toolchain files are processed multiple times and in some cases it does not have access
    # to cmake cache, so we need to store the compiler path in a temporary environment variable.
    if(NOT "$ENV{ENV_${COMPILER_PATH}}" STREQUAL "")
        set(${COMPILER_PATH} "$ENV{ENV_${COMPILER_PATH}}" PARENT_SCOPE)
        return()
    endif()

    find_program(${COMPILER_PATH} ${COMPILER_FILE} PATHS ${TOOLCHAIN_PATH})
    if("${${COMPILER_PATH}}" STREQUAL "${COMPILER_PATH}-NOTFOUND")
        message(FATAL_ERROR "Compiler not found, please specify compiler path")
    else()
        message(STATUS "Found compiler: ${${COMPILER_PATH}}")
    endif()

    # Store compiler path if found.
    set(ENV{ENV_${COMPILER_PATH}} "${${COMPILER_PATH}}")
endfunction()

# Gather source files under a folder.
function(get_source_files out_files)
    cmake_parse_arguments(PARSE_ARGV 1 "ARGS"
        "RECURSE"               # Whether to traverse all subdirectory.
        "DIRECTORY;EXTENSIONS"  # Specify location and file extensions.
        ""                      # No multi-value parameters.
    )

    if(ARGS_RECURSE)
        file(GLOB_RECURSE all_files LIST_DIRECTORIES false "${ARGS_DIRECTORY}/*")
    else()
        file(GLOB all_files LIST_DIRECTORIES false "${ARGS_DIRECTORY}/*")
    endif()

    # If no extension is specified, return C and assembly source code.
    if("${ARGS_EXTENSIONS}" STREQUAL "")
        set(ARGS_EXTENSIONS "c;C;h;H;s;S;asm;ASM")
    endif()

    # Filter files with regex.
    string(REPLACE ";" "|" ARGS_EXTENSIONS "${ARGS_EXTENSIONS}")
    set(regex_filter ".*\\.(${ARGS_EXTENSIONS})\$")
    list(FILTER all_files INCLUDE REGEX "${regex_filter}")

    # Set output variable.
    set(${out_files} "${all_files}" PARENT_SCOPE)
endfunction()

# Create a demos or tests project, can pass additional include paths or source files.
function(add_project)
    cmake_parse_arguments(PARSE_ARGV 0 "ARGS"
        ""                                      # No optional parameter.
        "TYPE"                                  # Specify project type, can be either demos or tests.
        "ADDITIONAL_SOURCE;ADDITIONAL_INCLUDE"  # Specify additional src, inc, compile and linker flags.
    )

    if("${ARGS_TYPE}" STREQUAL "demos")
        set(target_name aws_demos)
        set(board_prefix ${demos_board_prefix})
        set(link_targets afr_demos)
    elseif("${ARGS_TYPE}" STREQUAL "tests")
        set(target_name aws_tests)
        set(board_prefix ${tests_board_prefix})
        set(link_targets afr_tests)
    else()
        message(FATAL_ERROR "Project type should be demos or tests.")
    endif()
    list(APPEND link_targets 3rdparty_mcu)

    # Recusively get application code and config files.
    get_source_files(application_code DIRECTORY "${board_prefix}/application_code" RECURSE)
    get_source_files(config_files DIRECTORY "${board_prefix}/config_files" EXTENSIONS "h" RECURSE)

    # Create target, this would be either demos or tests.
    add_executable(
        ${target_name}
        ${application_code}
        ${config_files}
        ${ARGS_ADDITIONAL_SOURCE}
    )
    target_include_directories(
        ${target_name} PRIVATE
        "${board_prefix}/application_code"
        "${board_prefix}/application_code/${vendor}_code"
        "${board_prefix}/config_files"
        ${ARGS_ADDITIONAL_INCLUDE}
    )
    target_link_libraries(
        ${target_name} PRIVATE
        ${link_targets}
    )

    # Output source files and include directories list
    file(GENERATE OUTPUT "cmake_${target_name}_src.txt"
        CONTENT $<TARGET_PROPERTY:${target_name},SOURCES>
    )
    file(GENERATE OUTPUT "cmake_${target_name}_inc.txt"
        CONTENT $<TARGET_PROPERTY:${target_name},INCLUDE_DIRECTORIES>
    )
endfunction()

# Use this function to add a demos project.
function(add_demos_project)
    add_project(TYPE demos ${ARGV})
endfunction()

# Use this function to add a tests project.
function(add_tests_project)
    add_project(TYPE tests ${ARGV})
endfunction()

# Retrieve all dependencies of a target
function(get_dependencies out_dependencies in_target)
    get_target_property(_type ${in_target} TYPE)
    if("${_type}" STREQUAL "INTERFACE_LIBRARY")
        get_target_property(_dependencies ${in_target} INTERFACE_LINK_LIBRARIES)
    else()
        get_target_property(_dependencies ${in_target} LINK_LIBRARIES)
    endif()
    foreach(_dependency IN LISTS _dependencies)
        if(TARGET ${_dependency} AND NOT _dependency IN_LIST ${out_dependencies})
            list(APPEND ${out_dependencies} ${_dependency})
            get_dependencies(${out_dependencies} ${_dependency})
        endif()
    endforeach()
    set(${out_dependencies} "${${out_dependencies}}" PARENT_SCOPE)
endfunction()
