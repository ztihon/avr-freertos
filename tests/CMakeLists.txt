# -------------------------------------------------------------------------------------------------
# Tests
# -------------------------------------------------------------------------------------------------
# POSIX test
add_library(afr_test_posix INTERFACE)
get_source_files(afr_test_posix_src DIRECTORY "${tests_dir}/posix")
target_sources(
    afr_test_posix INTERFACE
    "${afr_test_posix_src}"
)
target_link_libraries(
    afr_test_posix INTERFACE
    afr_lib_kernel_plus_posix
)

# Crypto test
add_library(afr_test_crypto INTERFACE)
target_sources(
    afr_test_crypto INTERFACE
    "${tests_dir}/crypto/aws_test_crypto.c"
)
target_link_libraries(
    afr_test_crypto INTERFACE
    afr_lib_crypto
)

# Greengrass test
add_library(afr_test_greengrass INTERFACE)
target_sources(
    afr_test_greengrass INTERFACE
    "${tests_dir}/greengrass/aws_test_greengrass_discovery.c"
    "${tests_dir}/greengrass/aws_test_helper_secure_connect.c"
)
target_link_libraries(
    afr_test_greengrass INTERFACE
    afr_lib_greengrass
)

# MQTT test
add_library(afr_test_mqtt INTERFACE)
target_sources(
    afr_test_mqtt INTERFACE
    "${tests_dir}/mqtt/aws_test_mqtt_lib.c"
    "${tests_dir}/mqtt/aws_test_mqtt_agent.c"
)
target_link_libraries(
    afr_test_mqtt INTERFACE
    afr_lib_mqtt
)

# OTA test
add_library(afr_test_ota INTERFACE)
target_sources(
    afr_test_ota INTERFACE
    "${tests_dir}/ota/aws_test_ota_agent.c"
    "${tests_dir}/ota/aws_test_ota_pal.c"
)
target_include_directories(
    afr_test_ota INTERFACE
    "${tests_dir}/ota"
)
target_link_libraries(
    afr_test_ota INTERFACE
    afr_lib_ota
)

# PKCS11 test
add_library(afr_test_pkcs11 INTERFACE)
target_sources(
    afr_test_pkcs11 INTERFACE
    "${tests_dir}/pkcs11/aws_test_pkcs11.c"
)
target_link_libraries(
    afr_test_pkcs11 INTERFACE
    afr_lib_pkcs11
)

# Secure sockets test
add_library(afr_test_secure_sockets INTERFACE)
target_sources(
    afr_test_secure_sockets INTERFACE
    "${tests_dir}/secure_sockets/aws_test_tcp.c"
    "${tests_dir}/include/aws_test_tcp.h"
)
target_link_libraries(
    afr_test_secure_sockets INTERFACE
    afr_lib_secure_sockets
)

# TLS test
add_library(afr_test_tls INTERFACE)
target_sources(
    afr_test_tls INTERFACE
    "${tests_dir}/tls/aws_test_tls.c"
)
target_link_libraries(
    afr_test_tls INTERFACE
    afr_lib_secure_sockets
)

# Shadow test
add_library(afr_test_shadow INTERFACE)
target_sources(
    afr_test_shadow INTERFACE
    "${tests_dir}/shadow/aws_test_shadow.c"
)
target_link_libraries(
    afr_test_shadow INTERFACE
    afr_lib_shadow
)

# WiFi test
add_library(afr_test_wifi INTERFACE)
target_sources(
    afr_test_wifi INTERFACE
    "${tests_dir}/wifi/aws_test_wifi.c"
)
target_link_libraries(
    afr_test_wifi INTERFACE
    afr_lib_wifi
)

# Memory test
add_library(afr_test_memory INTERFACE)
target_sources(
    afr_test_memory INTERFACE
    "${tests_dir}/memory_leak/aws_memory_leak.c"
)

# Base tests target, test project only needs to link to this target
add_library(afr_tests INTERFACE)
target_sources(
    afr_tests INTERFACE
    "${tests_dir}/framework/aws_test_framework.c"
    "${tests_dir}/test_runner/aws_test_runner.c"
    "${tests_dir}/include/aws_test_framework.h"
    "${tests_dir}/include/aws_test_runner.h"
    "${tests_dir}/include/aws_clientcredential.h"
    "${tests_dir}/include/aws_clientcredential_keys.h"
)
target_include_directories(
    afr_tests INTERFACE
    "${tests_dir}/include"
)
target_link_libraries(
    afr_tests INTERFACE
    afr_lib_core
    3rdparty_unity
)
target_compile_definitions(afr_tests INTERFACE AMAZON_FREERTOS_ENABLE_UNIT_TESTS)

# -------------------------------------------------------------------------------------------------
# Default overridable test configuration
# -------------------------------------------------------------------------------------------------
set(
    supported_tests
    afr_test_memory
    afr_test_posix
    afr_test_crypto
    afr_test_pkcs11
    afr_test_wifi
    afr_test_secure_sockets
    afr_test_tls
    afr_test_mqtt
    afr_test_shadow
    afr_test_greengrass
    afr_test_ota
)

include("${PROJECT_SOURCE_DIR}/cmake/boards/${board_dir}/tests.cmake" OPTIONAL)

target_link_libraries(
    afr_tests INTERFACE
    ${supported_tests}
)
