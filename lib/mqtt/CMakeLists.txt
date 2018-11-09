add_library(afr_lib_mqtt INTERFACE)
target_sources(
    afr_lib_mqtt INTERFACE
    "${lib_dir}/mqtt/aws_mqtt_agent.c"
    "${lib_dir}/mqtt/aws_mqtt_lib.c"
    "${lib_dir}/include/aws_mqtt_agent.h"
    "${lib_dir}/include/aws_mqtt_lib.h"
    "${lib_dir}/include/private/aws_mqtt_buffer.h"
    "${lib_dir}/include/private/aws_mqtt_config_defaults.h"
    "${lib_dir}/include/private/aws_mqtt_agent_config_defaults.h"
    "${lib_dir}/include/private/aws_doubly_linked_list.h"
)
target_link_libraries(
    afr_lib_mqtt INTERFACE
    afr_lib_secure_sockets
    afr_lib_bufferpool
)
