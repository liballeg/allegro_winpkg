cmake_minimum_required(VERSION 2.6)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
      FORCE)
endif()

project(libogg C)

set(OGG_SRCS
    src/bitwise.c
    src/framing.c)

set(OGG_HDRS
    include/ogg/ogg.h
    include/ogg/os_types.h)

include_directories(include
                    ${CMAKE_BINARY_DIR}/include)

if(MSVC)
    add_definitions(/D_UNICODE /DUNICODE)
    list(APPEND OGG_SRCS win32/ogg.def)
endif()

if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
    include(CheckIncludeFiles)

    check_include_files(inttypes.h HAVE_INTTYPES_H)
    check_include_files(stdint.h HAVE_STDINT_H)
    check_include_files(sys/types.h HAVE_SYS_TYPES_H)

    set(INCLUDE_INTTYPES_H 0)
    set(INCLUDE_STDINT_H 0)
    set(INCLUDE_SYS_TYPES_H 0)

    if(HAVE_INTTYPES_H)
        set(INCLUDE_INTTYPES_H 1)
    endif()
    if(HAVE_STDINT_H)
        set(INCLUDE_STDINT_H 1)
    endif()
    if(HAVE_SYS_TYPES_H)
        set(INCLUDE_SYS_TYPES_H 1)
    endif()

    set(SIZE16 int16_t)
    set(USIZE16 uint16_t)
    set(SIZE32 int32_t)
    set(USIZE32 uint32_t)
    set(SIZE64 int64_t)

    configure_file(${CMAKE_SOURCE_DIR}/include/ogg/config_types.h.in
                   ${CMAKE_BINARY_DIR}/include/ogg/config_types.h
                   @ONLY)

    list(APPEND OGG_HDRS ${CMAKE_BINARY_DIR}/include/ogg/config_types.h)
endif()

add_library(ogg SHARED ${OGG_SRCS})
add_library(ogg_static ${OGG_SRCS})

install(TARGETS ogg ogg_static
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)

install(FILES ${OGG_HDRS} DESTINATION include/ogg)
