cmake_minimum_required(VERSION 2.6)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
      FORCE)
endif()

project(libFLAC C)

set(FLAC_SRCS
    src/libFLAC/bitmath.c
    src/libFLAC/bitreader.c
    src/libFLAC/bitwriter.c
    src/libFLAC/cpu.c
    src/libFLAC/crc.c
    src/libFLAC/fixed.c
    src/libFLAC/fixed_intrin_sse2.c
    src/libFLAC/fixed_intrin_ssse3.c
    src/libFLAC/float.c
    src/libFLAC/format.c
    src/libFLAC/lpc.c
    src/libFLAC/lpc_intrin_avx2.c
    src/libFLAC/lpc_intrin_sse2.c
    src/libFLAC/lpc_intrin_sse41.c
    src/libFLAC/lpc_intrin_sse.c
    src/libFLAC/md5.c
    src/libFLAC/memory.c
    src/libFLAC/metadata_iterators.c
    src/libFLAC/metadata_object.c
    src/libFLAC/stream_decoder.c
    src/libFLAC/stream_encoder.c
    src/libFLAC/stream_encoder_framing.c
    src/libFLAC/stream_encoder_intrin_avx2.c
    src/libFLAC/stream_encoder_intrin_sse2.c
    src/libFLAC/stream_encoder_intrin_ssse3.c
    src/libFLAC/window.c
    src/libFLAC/windows_unicode_filenames.c)

set(FLAC_HDRS
    include/FLAC/all.h
    include/FLAC/assert.h
    include/FLAC/callback.h
    include/FLAC/export.h
    include/FLAC/format.h
    include/FLAC/metadata.h
    include/FLAC/ordinals.h
    include/FLAC/stream_decoder.h
    include/FLAC/stream_encoder.h)

# XXX: Why doesn't this work with MSYS2?
if(CMAKE_SIZEOF_VOID_P EQUAL 4 AND MSVC)
    enable_language(ASM_NASM)
    set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -I${CMAKE_SOURCE_DIR}/src/libFLAC/ia32/")

    list(APPEND FLAC_SRCS
         src/libFLAC/ia32/cpu_asm.nasm
         src/libFLAC/ia32/fixed_asm.nasm
         src/libFLAC/ia32/lpc_asm.nasm)
endif()

include_directories(include src/libFLAC/include)

if(WIN32)
    list(APPEND FLAC_SRCS
         src/share/win_utf8_io/win_utf8_io.c)
endif()

include(CheckIncludeFiles)
check_include_files(stdint.h HAVE_STDINT_H)
check_include_files(cpuid.h HAVE_CPUID_H)
check_include_files(sys/param.h HAVE_SYS_PARAM_H)
if(MSVC)
    include(CheckFunctionExists)
    check_function_exists(lround HAVE_LROUND)
else()
    include(CheckLibraryExists)
    include(CheckFunctionExists)
    check_library_exists(m lround "" HAVE_LROUND)
    check_function_exists(fseeko HAVE_FSEEKO)
endif()

if(MSVC)
    if(HAVE_STDINT_H)
        add_definitions(/DHAVE_STDINT_H)
    endif()
    if(HAVE_CPUID_H)
        add_definitions(/DHAVE_CPUID_H)
    endif()
    if(HAVE_SYS_PARAM_H)
        add_definitions(/DHAVE_SYS_PARAM_H)
    endif()
    if(HAVE_LROUND)
        add_definitions(/DHAVE_LROUND)
    endif()
    add_definitions(/DPACKAGE_VERSION=\"1.3.2\")
    add_definitions(/DFLAC__NO_DLL)
    add_definitions(/DFLAC__HAS_OGG=0)
else()
    if(HAVE_STDINT_H)
        add_definitions(-DHAVE_STDINT_H)
    endif()
    if(HAVE_CPUID_H)
        add_definitions(-DHAVE_CPUID_H)
    endif()
    if(HAVE_SYS_PARAM_H)
        add_definitions(-DHAVE_SYS_PARAM_H)
    endif()
    if(HAVE_LROUND)
        add_definitions(-DHAVE_LROUND)
    endif()
    if(HAVE_FSEEKO)
        add_definitions(-DHAVE_FSEEKO)
    endif()
    add_definitions(-DPACKAGE_VERSION=\"1.3.2\")
    add_definitions(-DFLAC__HAS_OGG=0)
endif()

add_library(FLAC ${FLAC_SRCS})

if(MSVC)
    set_target_properties(FLAC PROPERTIES COMPILE_FLAGS "/MT /Zl")
endif()

install(TARGETS FLAC
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)

install(FILES ${FLAC_HDRS} DESTINATION include/FLAC)
