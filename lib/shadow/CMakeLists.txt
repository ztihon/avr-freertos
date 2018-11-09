add_library(afr_lib_shadow INTERFACE)
target_sources(
    afr_lib_shadow INTERFACE
    "${lib_dir}/shadow/aws_shadow.c"
    "${lib_dir}/shadow/aws_shadow_json.c"
    "${lib_dir}/include/aws_shadow.h"
    "${lib_dir}/include/private/aws_shadow_json.h"
    "${lib_dir}/include/private/aws_shadow_config_defaults.h"
)
target_link_libraries(
    afr_lib_shadow INTERFACE
    afr_lib_mqtt
    3rdparty_jsmn
)
