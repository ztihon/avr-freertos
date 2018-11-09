add_library(afr_lib_kernel INTERFACE)
set(
    sources
    "${lib_dir}/FreeRTOS/event_groups.c"
    "${lib_dir}/FreeRTOS/list.c"
    "${lib_dir}/FreeRTOS/queue.c"
    "${lib_dir}/FreeRTOS/stream_buffer.c"
    "${lib_dir}/FreeRTOS/tasks.c"
    "${lib_dir}/FreeRTOS/timers.c"
)
set(
    headers
    "${lib_dir}/include/event_groups.h"
    "${lib_dir}/include/FreeRTOS.h"
    "${lib_dir}/include/message_buffer.h"
    "${lib_dir}/include/queue.h"
    "${lib_dir}/include/semphr.h"
    "${lib_dir}/include/stream_buffer.h"
    "${lib_dir}/include/task.h"
    "${lib_dir}/include/timers.h"
    "${lib_dir}/include/private/deprecated_definitions.h"
    "${lib_dir}/include/private/list.h"
    "${lib_dir}/include/private/mpu_wrappers.h"
    "${lib_dir}/include/private/portable.h"
    "${lib_dir}/include/private/projdefs.h"
    "${lib_dir}/include/private/stack_macros.h"
)
target_sources(
    afr_lib_kernel INTERFACE
    ${sources}
    ${headers}
)
target_include_directories(
    afr_lib_kernel INTERFACE
    "${lib_dir}/include"
    "${lib_dir}/include/private"
)

# Default to heap4 from FreeRTOS.
if(NOT override_lib_heap)
    target_sources(
        afr_lib_kernel INTERFACE
        "${lib_dir}/FreeRTOS/portable/MemMang/heap_4.c"
    )
endif()
