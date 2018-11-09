add_library(afr_lib_secure_sockets INTERFACE)
target_sources(
    afr_lib_secure_sockets INTERFACE
    "${lib_dir}/include/aws_secure_sockets.h"
    "${lib_dir}/include/private/aws_secure_sockets_config_defaults.h"
)

if(NOT override_lib_secure_sockets)
    target_sources(
        afr_lib_secure_sockets INTERFACE
        "${lib_dir}/secure_sockets/${portable_dir}/aws_secure_sockets.c"
    )
    target_link_libraries(
        afr_lib_secure_sockets INTERFACE
        afr_lib_tls
    )
endif()
