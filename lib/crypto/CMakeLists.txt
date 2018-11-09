add_library(afr_lib_crypto INTERFACE)
target_sources(
    afr_lib_crypto INTERFACE
    "${lib_dir}/crypto/aws_crypto.c"
    "${lib_dir}/include/aws_crypto.h"
)
target_link_libraries(
    afr_lib_crypto INTERFACE
    3rdparty_mbedtls
)
