# TODO
# Nuget stuff

cmake_minimum_required(VERSION 3.5..3.27)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
      FORCE)
endif()

project(libopenmpt C CXX)

set(HDRS
    libopenmpt/libopenmpt_config.h
    libopenmpt/libopenmpt_version.h
    libopenmpt/libopenmpt.h
    libopenmpt/libopenmpt_stream_callbacks_buffer.h
    libopenmpt/libopenmpt_stream_callbacks_fd.h
    libopenmpt/libopenmpt_stream_callbacks_file.h
    libopenmpt/libopenmpt_stream_callbacks_file_mingw.h
    libopenmpt/libopenmpt_stream_callbacks_file_msvcrt.h
    libopenmpt/libopenmpt_stream_callbacks_file_posix.h
    libopenmpt/libopenmpt_stream_callbacks_file_posix_lfs64.h
    libopenmpt/libopenmpt.hpp
    libopenmpt/libopenmpt_ext.h
    libopenmpt/libopenmpt_ext.hpp
    )

set(SRCS
    common/ComponentManager.cpp
    common/Logging.cpp
    common/Profiler.cpp
    common/mptFileIO.cpp
    common/mptFileTemporary.cpp
    common/mptFileType.cpp
    common/mptPathString.cpp
    common/mptRandom.cpp
    common/mptStringBuffer.cpp
    common/mptTime.cpp
    common/serialization_utils.cpp
    common/version.cpp
    soundlib/AudioCriticalSection.cpp
    soundlib/ContainerMMCMP.cpp
    soundlib/ContainerPP20.cpp
    soundlib/ContainerUMX.cpp
    soundlib/ContainerXPK.cpp
    soundlib/Dlsbank.cpp
    soundlib/Fastmix.cpp
    soundlib/ITCompression.cpp
    soundlib/ITTools.cpp
    soundlib/InstrumentExtensions.cpp
    soundlib/Load_667.cpp
    soundlib/Load_669.cpp
    soundlib/Load_amf.cpp
    soundlib/Load_ams.cpp
    soundlib/Load_c67.cpp
    soundlib/Load_dbm.cpp
    soundlib/Load_digi.cpp
    soundlib/Load_dmf.cpp
    soundlib/Load_dsm.cpp
    soundlib/Load_dsym.cpp
    soundlib/Load_dtm.cpp
    soundlib/Load_far.cpp
    soundlib/Load_fmt.cpp
    soundlib/Load_gdm.cpp
    soundlib/Load_gt2.cpp
    soundlib/Load_imf.cpp
    soundlib/Load_it.cpp
    soundlib/Load_itp.cpp
    soundlib/Load_mdl.cpp
    soundlib/Load_med.cpp
    soundlib/Load_mid.cpp
    soundlib/Load_mo3.cpp
    soundlib/Load_mod.cpp
    soundlib/Load_mt2.cpp
    soundlib/Load_mtm.cpp
    soundlib/Load_mus_km.cpp
    soundlib/Load_okt.cpp
    soundlib/Load_plm.cpp
    soundlib/Load_psm.cpp
    soundlib/Load_ptm.cpp
    soundlib/Load_s3m.cpp
    soundlib/Load_sfx.cpp
    soundlib/Load_stm.cpp
    soundlib/Load_stp.cpp
    soundlib/Load_symmod.cpp
    soundlib/Load_uax.cpp
    soundlib/Load_ult.cpp
    soundlib/Load_wav.cpp
    soundlib/Load_xm.cpp
    soundlib/Load_xmf.cpp
    soundlib/MIDIEvents.cpp
    soundlib/MIDIMacros.cpp
    soundlib/MPEGFrame.cpp
    soundlib/Message.cpp
    soundlib/MixFuncTable.cpp
    soundlib/MixerLoops.cpp
    soundlib/MixerSettings.cpp
    soundlib/ModChannel.cpp
    soundlib/ModInstrument.cpp
    soundlib/ModSample.cpp
    soundlib/ModSequence.cpp
    soundlib/OPL.cpp
    soundlib/OggStream.cpp
    soundlib/Paula.cpp
    soundlib/RowVisitor.cpp
    soundlib/S3MTools.cpp
    soundlib/SampleFormatBRR.cpp
    soundlib/SampleFormatFLAC.cpp
    soundlib/SampleFormatMP3.cpp
    soundlib/SampleFormatMediaFoundation.cpp
    soundlib/SampleFormatOpus.cpp
    soundlib/SampleFormatSFZ.cpp
    soundlib/SampleFormatVorbis.cpp
    soundlib/SampleFormats.cpp
    soundlib/SampleIO.cpp
    soundlib/Snd_flt.cpp
    soundlib/Snd_fx.cpp
    soundlib/Sndfile.cpp
    soundlib/Sndmix.cpp
    soundlib/SoundFilePlayConfig.cpp
    soundlib/Tables.cpp
    soundlib/Tagging.cpp
    soundlib/TinyFFT.cpp
    soundlib/UMXTools.cpp
    soundlib/UpgradeModule.cpp
    soundlib/WAVTools.cpp
    soundlib/WindowedFIR.cpp
    soundlib/XMTools.cpp
    soundlib/load_j2b.cpp
    soundlib/mod_specifications.cpp
    soundlib/modcommand.cpp
    soundlib/modsmp_ctrl.cpp
    soundlib/pattern.cpp
    soundlib/patternContainer.cpp
    soundlib/tuning.cpp
    soundlib/tuningCollection.cpp
    soundlib/plugins/DigiBoosterEcho.cpp
    soundlib/plugins/LFOPlugin.cpp
    soundlib/plugins/PlugInterface.cpp
    soundlib/plugins/PluginManager.cpp
    soundlib/plugins/SymMODEcho.cpp
    soundlib/plugins/dmo/Chorus.cpp
    soundlib/plugins/dmo/Compressor.cpp
    soundlib/plugins/dmo/DMOPlugin.cpp
    soundlib/plugins/dmo/DMOUtils.cpp
    soundlib/plugins/dmo/Distortion.cpp
    soundlib/plugins/dmo/Echo.cpp
    soundlib/plugins/dmo/Flanger.cpp
    soundlib/plugins/dmo/Gargle.cpp
    soundlib/plugins/dmo/I3DL2Reverb.cpp
    soundlib/plugins/dmo/ParamEq.cpp
    soundlib/plugins/dmo/WavesReverb.cpp
    sounddsp/AGC.cpp
    sounddsp/DSP.cpp
    sounddsp/EQ.cpp
    sounddsp/Reverb.cpp
    libopenmpt/libopenmpt_c.cpp
    libopenmpt/libopenmpt_cxx.cpp
    libopenmpt/libopenmpt_ext_impl.cpp
    libopenmpt/libopenmpt_impl.cpp
    include/minimp3/minimp3.c
    )

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
include(FindOgg)
include(FindVorbis)

find_package(ZLIB REQUIRED)
find_package(Ogg REQUIRED)
find_package(Vorbis REQUIRED)

include_directories(include
                    .
                    src
                    common
                    ${OGG_INCLUDE_DIR}
                    ${VORBIS_INCLUDE_DIR}
                    ${ZLIB_INCLUDE_DIR}
                    )

add_definitions(
    -DMPT_WITH_ZLIB
    -DMPT_WITH_VORBIS
    -DMPT_WITH_OGG
    -DMPT_WITH_VORBISFILE
    -DLIBOPENMPT_BUILD
    -DMPT_WITH_MINIMP3
    -D_UNICODE
    -DUNICODE
    )

add_library(openmpt ${SRCS})
target_link_libraries(openmpt "${VORBIS_LIBRARIES}" "${ZLIB_LIBRARY}")
if(NOT MSVC)
    # libm is required when linking statically.
    target_link_libraries(openmpt m)
endif()

if(MSVC)
    set_target_properties(openmpt PROPERTIES COMPILE_FLAGS "/MT /Zl")
    target_compile_features(openmpt PRIVATE cxx_std_17)
endif()

install(TARGETS openmpt
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)

install(FILES ${HDRS} DESTINATION include/libopenmpt)