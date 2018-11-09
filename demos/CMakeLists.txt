# -------------------------------------------------------------------------------------------------
# Demos
# -------------------------------------------------------------------------------------------------
# Key provisioning
add_library(afr_demo_key_provisioning INTERFACE)
target_sources(
    afr_demo_key_provisioning INTERFACE
    "${demos_dir}/devmode_key_provisioning/aws_dev_mode_key_provisioning.c"
    "${demos_dir}/include/aws_dev_mode_key_provisioning.h"
)
target_link_libraries(
    afr_demo_key_provisioning INTERFACE
    afr_lib_pkcs11
)

# Logging
add_library(afr_demo_logging INTERFACE)
target_sources(
    afr_demo_logging INTERFACE
    "${demos_dir}/logging/aws_logging_task_dynamic_buffers.c"
    "${demos_dir}/include/aws_logging_task.h"
)

# MQTT hello world demo
add_library(afr_demo_mqtt_hello_world INTERFACE)
target_sources(
    afr_demo_mqtt_hello_world INTERFACE
    "${demos_dir}/mqtt/aws_hello_world.c"
    "${demos_dir}/include/aws_hello_world.h"
)
target_link_libraries(
    afr_demo_mqtt_hello_world INTERFACE
    afr_lib_mqtt
)

# MQTT publish subscribe demo
add_library(afr_demo_mqtt_pubsub INTERFACE)
target_sources(
    afr_demo_mqtt_pubsub INTERFACE
    "${demos_dir}/mqtt/aws_subscribe_publish_loop.c"
    "${demos_dir}/include/aws_subscribe_publish_loop.h"
)
target_link_libraries(
    afr_demo_mqtt_pubsub INTERFACE
    afr_lib_mqtt
)

# TCP echo demo
# TODO, tcp echo client separate tasks is not supported in NXP
add_library(afr_demo_tcp INTERFACE)
target_sources(
    afr_demo_tcp INTERFACE
    #"${demos_dir}/tcp/aws_tcp_echo_client_separate_tasks.c"
    "${demos_dir}/tcp/aws_tcp_echo_client_single_task.c"
    "${demos_dir}/include/aws_tcp_echo_client_single_tasks.h"
)
target_link_libraries(
    afr_demo_tcp INTERFACE
    afr_lib_secure_sockets
)

# Shadow demo
add_library(afr_demo_shadow INTERFACE)
target_sources(
    afr_demo_shadow INTERFACE
    "${demos_dir}/shadow/aws_shadow_lightbulb_on_off.c"
    "${demos_dir}/include/aws_shadow_lightbulb_on_off.h"
)
target_link_libraries(
    afr_demo_shadow INTERFACE
    afr_lib_shadow
)

# Greengrass demo
add_library(afr_demo_greengrass INTERFACE)
target_sources(
    afr_demo_greengrass INTERFACE
    "${demos_dir}/greengrass_connectivity/aws_greengrass_discovery_demo.c"
    "${demos_dir}/include/aws_greengrass_discovery_demo.h"
)
target_link_libraries(
    afr_demo_greengrass INTERFACE
    afr_lib_greengrass
)

# OTA demo
add_library(afr_demo_ota INTERFACE)
target_sources(
    afr_demo_ota INTERFACE
    "${demos_dir}/ota/aws_ota_update_demo.c"
    "${demos_dir}/include/aws_ota_update_demo.h"
)
target_link_libraries(
    afr_demo_ota INTERFACE
    afr_lib_ota
)

# Base demos target, demo project only needs to link to this target
add_library(afr_demos INTERFACE)
target_sources(
    afr_demos INTERFACE
    "${demos_dir}/demo_runner/aws_demo_runner.c"
    "${demos_dir}/include/aws_demo.h"
    "${demos_dir}/include/aws_demo_runner.h"
    "${demos_dir}/include/aws_clientcredential.h"
    "${demos_dir}/include/aws_clientcredential_keys.h"
    "${demos_dir}/include/aws_application_version.h"
)
target_include_directories(
    afr_demos INTERFACE
    "${demos_dir}/include"
)
target_link_libraries(
    afr_demos INTERFACE
    afr_lib_core
)

# -------------------------------------------------------------------------------------------------
# Default overridable demo configuration
# -------------------------------------------------------------------------------------------------
set(
    supported_demos
    afr_demo_mqtt_hello_world
    afr_demo_mqtt_pubsub
    afr_demo_tcp
    afr_demo_shadow
    afr_demo_greengrass
    afr_demo_ota
)

# Add additional configurations if exists.
include("${PROJECT_SOURCE_DIR}/cmake/boards/${board_dir}/demos.cmake" OPTIONAL)

target_link_libraries(
    afr_demos INTERFACE
    ${supported_demos}
)
