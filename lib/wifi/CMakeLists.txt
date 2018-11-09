add_library(afr_lib_wifi INTERFACE)
get_source_files(afr_lib_wifi_port_src DIRECTORY "${portable_dir}" RECURSE)
target_sources(
    afr_lib_wifi INTERFACE
    "${lib_dir}/include/aws_wifi.h"
    ${afr_lib_wifi_port_src}
)
