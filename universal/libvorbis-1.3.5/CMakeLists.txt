cmake_minimum_required(VERSION 2.6)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
      FORCE)
endif()

project(libvorbis C)

set(VORBIS_SRCS
    lib/analysis.c
    lib/bitrate.c
    lib/block.c
    lib/codebook.c
    lib/envelope.c
    lib/floor0.c
    lib/floor1.c
    lib/info.c
    lib/lookup.c
    lib/lpc.c
    lib/lsp.c
    lib/mapping0.c
    lib/mdct.c
    lib/psy.c
    lib/registry.c
    lib/res0.c
    lib/sharedbook.c
    lib/smallft.c
    lib/synthesis.c
    lib/vorbisenc.c
    lib/window.c)

set(VORBIS_HDRS
    include/vorbis/codec.h
    include/vorbis/vorbisenc.h)

set(VORBISFILE_SRCS
    lib/vorbisfile.c)

set(VORBISFILE_HDRS
    include/vorbis/vorbisfile.h)

include_directories(include lib)

if(MSVC)
    add_definitions(/D_UNICODE /DUNICODE)
    list(APPEND VORBIS_SRCS win32/vorbis.def)
    list(APPEND VORBISFILE_SRCS win32/vorbisfile.def)
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR})
include(FindOgg)
find_package(Ogg)
if(NOT OGG_FOUND)
    message(FATAL_ERROR "Ogg required.")
endif()

include_directories("${OGG_INCLUDE_DIR}")

add_library(vorbis SHARED ${VORBIS_SRCS})
add_library(vorbis_static ${VORBIS_SRCS})
add_library(vorbisfile SHARED ${VORBISFILE_SRCS})
add_library(vorbisfile_static ${VORBISFILE_SRCS})

if(MSVC)
    set_target_properties(vorbis_static PROPERTIES COMPILE_FLAGS /MT)
    set_target_properties(vorbisfile_static PROPERTIES COMPILE_FLAGS /MT)
endif()

target_link_libraries(vorbis "${OGG_LIBRARIES}")
target_link_libraries(vorbisfile "${OGG_LIBRARIES};vorbis")

install(TARGETS vorbis vorbis_static vorbisfile vorbisfile_static
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)

install(FILES ${VORBIS_HDRS} ${VORBISFILE_HDRS} DESTINATION include/vorbis)
