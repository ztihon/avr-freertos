add_library(afr_lib_ota INTERFACE)
get_source_files(afr_lib_ota_port_src DIRECTORY "${portable_dir}" RECURSE)
target_sources(
    afr_lib_ota INTERFACE
    "${lib_dir}/ota/aws_ota_agent.c"
    "${lib_dir}/ota/aws_ota_cbor.c"
    "${lib_dir}/include/aws_ota_agent.h"
    "${lib_dir}/include/private/aws_ota_cbor.h"
    "${lib_dir}/include/private/aws_ota_pal.h"
    "${lib_dir}/include/private/aws_ota_types.h"
    "${lib_dir}/include/private/aws_ota_agent_internal.h"
    "${lib_dir}/include/private/aws_ota_cbor_internal.h"
    ${afr_lib_ota_port_src}
)
target_include_directories(
    afr_lib_ota INTERFACE
    "${lib_dir}/ota/${portable_dir}"
)
target_link_libraries(
    afr_lib_ota INTERFACE
    afr_lib_mqtt
    3rdparty_tinycbor
    3rdparty_jsmn
)
