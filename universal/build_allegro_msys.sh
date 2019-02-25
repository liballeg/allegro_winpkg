#!/bin/bash

if [[ $# -ne 4 ]]
then
	echo Usage: $0 GENERATOR BUILD_DIR DEPS_DIR OUTPUT_DIR
	echo Example: $0 '"MSYS Makefiles"' build_msys_32 allegro_deps_msys_32 allegro_msys_32
	exit 1
fi

root=$(pwd)
generator=$1
build_dir="$root/$2"
deps_dir="$root/$3"
static_output_dir="$root/$4/static_rt"
dynamic_output_dir="$root/$4/dynamic_rt"
parallel=-j8

common_args="-DCMAKE_FIND_ROOT_PATH=\"${deps_dir}\""
common_args="${common_args} -DWANT_EXAMPLES=off -DWANT_TESTS=off -DWANT_DEMO=off -DWANT_ACODEC_DYNAMIC_LOAD=off -DFLAC_STATIC=on -DWANT_OPENAL=off"
common_args="${common_args} -DZLIB_INCLUDE_DIR=\"${deps_dir}/include\" -DZLIB_LIBRARY=\"${deps_dir}/lib/libzlib.a\""
common_args="${common_args} -DPNG_PNG_INCLUDE_DIR=\"${deps_dir}/include\" -DPNG_LIBRARY_RELEASE=\"${deps_dir}/lib/libpng16.a\""
common_args="${common_args} -DJPEG_INCLUDE_DIR=\"${deps_dir}/include\" -DJPEG_LIBRARY=\"${deps_dir}/lib/libjpeg.a\""
common_args="${common_args} -DFLAC_INCLUDE_DIR=\"${deps_dir}/include\" -DFLAC_LIBRARY=\"${deps_dir}/lib/libFLAC.a\""
common_args="${common_args} -DDUMB_INCLUDE_DIR=\"${deps_dir}/include\" -DDUMB_LIBRARY=\"${deps_dir}/lib/libdumb.a\""
common_args="${common_args} -DVORBIS_INCLUDE_DIR=\"${deps_dir}/include\" -DVORBIS_LIBRARY=\"${deps_dir}/lib/libvorbis.a\" -DVORBISFILE_LIBRARY=\"${deps_dir}/lib/libvorbisfile.a\""
common_args="${common_args} -DOGG_INCLUDE_DIR=\"${deps_dir}/include\" -DOGG_LIBRARY=\"${deps_dir}/lib/libogg.a\""
common_args="${common_args} -DFREETYPE_INCLUDE_DIR_freetype2=\"${deps_dir}/include/freetype2\" -DFREETYPE_INCLUDE_DIR_ft2build=\"${deps_dir}/include/freetype2\" -DFREETYPE_LIBRARY=\"${deps_dir}/lib/libfreetype.a\" -DFREETYPE_ZLIB=on -DFREETYPE_PNG=on"
common_args="${common_args} -DPHYSFS_INCLUDE_DIR=\"${deps_dir}/include\" -DPHYSFS_LIBRARY=\"${deps_dir}/lib/libphysfs.a\""
common_args="${common_args} -DTHEORA_INCLUDE_DIR=\"${deps_dir}/include\" -DTHEORA_LIBRARY=\"${deps_dir}/lib/libtheoradec.a\""
common_args="${common_args} -DOPUS_INCLUDE_DIR=\"${deps_dir}/include/opus\" -DOPUS_LIBRARY=\"${deps_dir}/lib/libopus.a\" -DOPUSFILE_LIBRARY=\"${deps_dir}/lib/libopusfile.a\""
common_args="${common_args} -DWEBP_INCLUDE_DIRS=\"${deps_dir}/include/webp\" -DWEBP_LIBRARIES=\"${deps_dir}/lib/libwebp.a\""

if [ -n "$generator" ]
then
	common_args="${common_args} -G \"${generator}\""
fi

set -x
set -e

mkdir -p "${build_dir}/allegro"
cd ${build_dir}/allegro

eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=off -DSHARED=on -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=RelWithDebInfo ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=on -DSHARED=on -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=RelWithDebInfo ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=off -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=RelWithDebInfo ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=on -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=RelWithDebInfo ${common_args}
make install ${parallel}

eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=off -DSHARED=on -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=Debug ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=on -DSHARED=on -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=Debug ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=off -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=Debug ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${static_output_dir}" -DWANT_MONOLITH=on -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=Debug ${common_args}
make install ${parallel}

eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${dynamic_output_dir}" -DWANT_MONOLITH=off -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=RelWithDebInfo ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${dynamic_output_dir}" -DWANT_MONOLITH=on -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=RelWithDebInfo ${common_args}
make install ${parallel}

eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${dynamic_output_dir}" -DWANT_MONOLITH=off -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=Debug ${common_args}
make install ${parallel}
eval cmake "${root}/allegro" -DCMAKE_INSTALL_PREFIX="${dynamic_output_dir}" -DWANT_MONOLITH=on -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=Debug ${common_args}
make install ${parallel}
