add_library(afr_lib_bufferpool INTERFACE)
target_sources(
    afr_lib_bufferpool INTERFACE
    "${lib_dir}/bufferpool/aws_bufferpool_static_thread_safe.c"
    "${lib_dir}/include/private/aws_bufferpool.h"
)
