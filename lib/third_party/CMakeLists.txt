# -------------------------------------------------------------------------------------------------
# 3rdparty libraries
# -------------------------------------------------------------------------------------------------
# MCU vendor target, demo and test projects will link to this target
add_library(3rdparty_mcu INTERFACE)

# jsmn - JSON parser
add_library(3rdparty_jsmn INTERFACE)
target_sources(
    3rdparty_jsmn INTERFACE
    "${3rdparty_dir}/jsmn/jsmn.h"
    "${3rdparty_dir}/jsmn/jsmn.c"
)
target_include_directories(
    3rdparty_jsmn INTERFACE
    "${3rdparty_dir}/jsmn"
)

# mbedtls - TLS protocol implementation
add_library(3rdparty_mbedtls INTERFACE)
get_source_files(mbedtls_src DIRECTORY "${3rdparty_dir}/mbedtls" RECURSE)
target_sources(
    3rdparty_mbedtls INTERFACE
    ${mbedtls_src}
)
target_include_directories(
    3rdparty_mbedtls INTERFACE
    "${3rdparty_dir}/mbedtls/include"
)

# OTA depends on only 1 file from mbedtls
target_sources(
    afr_lib_ota INTERFACE
    "${3rdparty_dir}/mbedtls/library/base64.c"
    "${3rdparty_dir}/mbedtls/include/mbedtls/base64.h"
)
target_include_directories(
    afr_lib_ota INTERFACE
    "${3rdparty_dir}/mbedtls/include"
)

# pkcs11 standard header
add_library(3rdparty_pkcs11 INTERFACE)
target_include_directories(
    3rdparty_pkcs11 INTERFACE
    "${3rdparty_dir}/pkcs11"
)

# tinycbor - CBOR implementation
add_library(3rdparty_tinycbor INTERFACE)
get_source_files(tinycbor_src DIRECTORY "${3rdparty_dir}/tinycbor" RECURSE)
target_sources(
    3rdparty_tinycbor INTERFACE
    ${tinycbor_src}
)
target_include_directories(
    3rdparty_tinycbor INTERFACE
    "${3rdparty_dir}/tinycbor"
)

# tracealyzer - Trace record library from FreeRTOS
add_library(3rdparty_tracealyzer INTERFACE)
target_sources(
    3rdparty_tracealyzer INTERFACE
    "${3rdparty_dir}/tracealyzer_recorder/trcKernelPort.c"
    "${3rdparty_dir}/tracealyzer_recorder/trcSnapshotRecorder.c"
)
target_include_directories(
    3rdparty_tracealyzer INTERFACE
    "${3rdparty_dir}/tracealyzer_recorder/include"
)

# WinPcap - pcap port for windows
add_library(3rdparty_winpcap INTERFACE)
target_include_directories(3rdparty_winpcap INTERFACE "${3rdparty_dir}/win_pcap")
if(MSVC)
    target_link_libraries(3rdparty_winpcap INTERFACE "${3rdparty_dir}/win_pcap/wpcap.lib")
elseif(MINGW)
    target_link_libraries(3rdparty_winpcap INTERFACE "${3rdparty_dir}/win_pcap/libwpcap.a")
endif()

# unity - test framework
add_library(3rdparty_unity INTERFACE)
target_sources(
    3rdparty_unity INTERFACE
    "${3rdparty_dir}/unity/src/unity.c"
    "${3rdparty_dir}/unity/src/unity.h"
    "${3rdparty_dir}/unity/src/unity_internals.h"
    "${3rdparty_dir}/unity/extras/fixture/src/unity_fixture.c"
    "${3rdparty_dir}/unity/extras/fixture/src/unity_fixture.h"
    "${3rdparty_dir}/unity/extras/fixture/src/unity_fixture_internals.h"
    "${3rdparty_dir}/unity/extras/fixture/src/unity_fixture_malloc_overrides.h"
)
target_include_directories(
    3rdparty_unity INTERFACE
    "${3rdparty_dir}/unity/src"
    "${3rdparty_dir}/unity/extras/fixture/src"
)
target_compile_definitions(3rdparty_unity INTERFACE UNITY_INCLUDE_CONFIG_H)

# cmock - mock framework
add_library(3rdparty_cmock INTERFACE)
target_sources(
    3rdparty_cmock INTERFACE
    "${3rdparty_dir}/cmock/src/cmock.c"
    "${3rdparty_dir}/cmock/src/cmock.h"
    "${3rdparty_dir}/cmock/src/cmock_internals.h"
)
target_include_directories(
    3rdparty_cmock INTERFACE
    "${3rdparty_dir}/cmock/src"
)
