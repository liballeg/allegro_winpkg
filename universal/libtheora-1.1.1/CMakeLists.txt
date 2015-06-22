cmake_minimum_required(VERSION 2.6)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
      FORCE)
endif()

project(libtheora C)

set(THEORADEC_SRCS
    lib/apiwrapper.c
    lib/bitpack.c
    lib/decapiwrapper.c
    lib/decinfo.c
    lib/decode.c
    lib/dequant.c
    lib/fragment.c
    lib/huffdec.c
    lib/idct.c
    lib/info.c
    lib/internal.c
    lib/quant.c
    lib/state.c)

set(THEORADEC_HDRS
    include/theora/codec.h
    include/theora/theora.h
    include/theora/theoradec.h)

include_directories(include lib)

if(MSVC)
    add_definitions(/D_UNICODE /DUNICODE)
    list(APPEND THEORADEC_SRCS
         lib/x86_vc/mmxfrag.c
         lib/x86_vc/mmxidct.c
         lib/x86_vc/mmxstate.c
         lib/x86_vc/x86state.c
         win32/xmingw32/libtheoradec-all.def)
else()
    list(APPEND THEORADEC_SRCS
         lib/x86/mmxfrag.c
         lib/x86/mmxidct.c
         lib/x86/mmxstate.c
         lib/x86/x86state.c)
    add_definitions(-DOC_X86_ASM)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-aggressive-loop-optimizations")

    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        add_definitions(-DOC_X86_64_ASM)
    endif()
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR})
include(FindOgg)
find_package(Ogg)
if(NOT OGG_FOUND)
    message(FATAL_ERROR "Ogg required.")
endif()

include_directories("${OGG_INCLUDE_DIR}")

add_library(theoradec SHARED ${THEORADEC_SRCS})
add_library(theoradec_static ${THEORADEC_SRCS})

if(MSVC)
    set_target_properties(theoradec_static PROPERTIES COMPILE_FLAGS /MT)
endif()

target_link_libraries(theoradec "${OGG_LIBRARIES}")

install(TARGETS theoradec theoradec_static
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)

install(FILES ${THEORADEC_HDRS} DESTINATION include/theora)
