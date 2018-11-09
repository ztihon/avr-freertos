add_library(afr_lib_utils INTERFACE)
target_sources(
    afr_lib_utils INTERFACE
    "${lib_dir}/utils/aws_system_init.c"
)
