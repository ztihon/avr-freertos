add_library(afr_lib_greengrass INTERFACE)
target_sources(
    afr_lib_greengrass INTERFACE
    "${lib_dir}/greengrass/aws_greengrass_discovery.c"
    "${lib_dir}/greengrass/aws_helper_secure_connect.c"
    "${lib_dir}/include/aws_greengrass_discovery.h"
    "${lib_dir}/include/private/aws_helper_secure_connect.h"
    "${lib_dir}/include/private/aws_ggd_config_defaults.h"
)
target_link_libraries(
    afr_lib_greengrass INTERFACE
    afr_lib_mqtt
    3rdparty_jsmn
)
