cmake_minimum_required(VERSION 2.6)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
      FORCE)
endif()

project(libopusfile C)

set(OPUSFILE_SRCS
    src/info.c
	src/internal.c
	src/opusfile.c
	src/stream.c)

set(OPUSFILE_HDRS
    include/opusfile.h)

include_directories(include src)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR})
include(FindOpus)
find_package(Opus)
include(FindOgg)
find_package(Ogg)

if(NOT OPUS_FOUND)
    message(FATAL_ERROR "Opus required.")
endif()
if(NOT OGG_FOUND)
    message(FATAL_ERROR "Ogg required.")
endif()

include_directories("${OPUS_INCLUDE_DIR}" "${OGG_INCLUDE_DIR}")

add_library(opusfile ${OPUSFILE_SRCS})

if(MSVC)
    set_target_properties(opusfile PROPERTIES COMPILE_FLAGS "/MT /Zl")
endif()

install(TARGETS opusfile
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)

install(FILES ${OPUSFILE_HDRS} DESTINATION include/opus)
