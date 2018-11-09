# Windows simulator doesn't have WiFi.
list(REMOVE_ITEM supported_tests afr_test_wifi)

# OTA CBOR tests are only supported on Windows simulator.
target_sources(
    afr_test_ota INTERFACE
    "${tests_dir}/ota/aws_test_ota_cbor.c"
)
