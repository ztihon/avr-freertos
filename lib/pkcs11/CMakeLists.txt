add_library(afr_lib_pkcs11 INTERFACE)
get_source_files(sources DIRECTORY "${portable_dir}" RECURSE)
target_sources(
    afr_lib_pkcs11 INTERFACE
    ${sources}
)
target_link_libraries(
    afr_lib_pkcs11 INTERFACE
    3rdparty_pkcs11
)

# Default implementation for PKCS11 is based on mbedtls.
if(NOT override_lib_pkcs11)
    target_sources(
        afr_lib_pkcs11 INTERFACE
        "${lib_dir}/pkcs11/mbedtls/aws_pkcs11_mbedtls.c"
    )
endif()
