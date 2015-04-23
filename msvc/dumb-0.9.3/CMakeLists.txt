cmake_minimum_required(VERSION 2.6)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
      FORCE)
endif()

project(libdumb C)

set(DUMB_SRCS
    src/core/atexit.c
    src/core/duhlen.c
    src/core/duhtag.c
    src/core/dumbfile.c
    src/core/loadduh.c
    src/core/makeduh.c
    src/core/rawsig.c
    src/core/readduh.c
    src/core/register.c
    src/core/rendduh.c
    src/core/rendsig.c
    src/core/unload.c
    src/helpers/clickrem.c
    src/helpers/memfile.c
    src/helpers/resample.c
    src/helpers/sampbuf.c
    src/helpers/silence.c
    src/helpers/stdfile.c
    src/it/itload.c
    src/it/itread.c
    src/it/itload2.c
    src/it/itread2.c
    src/it/itrender.c
    src/it/itunload.c
    src/it/loads3m.c
    src/it/reads3m.c
    src/it/loadxm.c
    src/it/readxm.c
    src/it/loadmod.c
    src/it/readmod.c
    src/it/loads3m2.c
    src/it/reads3m2.c
    src/it/loadxm2.c
    src/it/readxm2.c
    src/it/loadmod2.c
    src/it/readmod2.c
    src/it/xmeffect.c
    src/it/itorder.c
    src/it/itmisc.c)

set(DUMB_HDRS
    include/dumb.h)

include_directories(include
                    ${CMAKE_BINARY_DIR}/include)

if(MSVC)
	add_definitions(/DDUMB_DECLARE_DEPRECATED)
else()
	add_definitions(-DDUMB_DECLARE_DEPRECATED)
endif()

add_library(dumb_static ${DUMB_SRCS})

install(TARGETS dumb_static
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)

install(FILES ${DUMB_HDRS} DESTINATION include)
