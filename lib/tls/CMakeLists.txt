add_library(afr_lib_tls INTERFACE)
target_sources(
    afr_lib_tls INTERFACE
    "${lib_dir}/tls/aws_tls.c"
    "${lib_dir}/include/aws_tls.h"
)
target_link_libraries(
    afr_lib_tls INTERFACE
    afr_lib_crypto
    afr_lib_pkcs11
    3rdparty_mbedtls
)
