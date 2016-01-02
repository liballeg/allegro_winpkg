#!/bin/bash

if [[ $# -ne 3 ]]
then
	echo Usage: $0 GENERATOR BUILD_DIR OUTPUT_DIR
	echo Example: $0 '"MSYS Makefiles"' build_msys_32 allegro_deps_msys_32
	exit 1
fi

root=$(pwd)
generator=$1
build_dir="$root/$2"
output_dir="$root/$3"
parallel=-j2

common_args="-DCMAKE_PREFIX_PATH=\"${output_dir}\" -DCMAKE_INSTALL_PREFIX=\"${output_dir}\""
if [ -n "$generator" ]
then
	common_args="${common_args} -G \"${generator}\""
fi

set -x
set -e

mkdir -p "${build_dir}/zlib"
cd "${build_dir}/zlib"
eval cmake "${root}/zlib-1.2.8" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/physfs"
cd "${build_dir}/physfs"
eval cmake "${root}/physfs-2.0.3" ${common_args} -DPHYSFS_BUILD_TEST=off
make install ${parallel}

mkdir -p "${build_dir}/dumb"
cd "${build_dir}/dumb"
eval cmake "${root}/dumb-0.9.3" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/freetype"
cd "${build_dir}/freetype"
eval cmake "${root}/freetype-2.5.5" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libjpeg-turbo"
cd "${build_dir}/libjpeg-turbo"
eval cmake "${root}/libjpeg-turbo-1.4.0" ${common_args} -DWITH_TURBOJPEG=false
make install ${parallel}

mkdir -p "${build_dir}/libpng"
cd ${build_dir}/libpng
eval cmake "${root}/libpng-1.6.17" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libogg"
cd ${build_dir}/libogg
eval cmake "${root}/libogg-1.3.2" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libvorbis"
cd ${build_dir}/libvorbis
eval cmake "${root}/libvorbis-1.3.5" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libtheora"
cd ${build_dir}/libtheora
eval cmake "${root}/libtheora-1.1.1" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/flac"
cd ${build_dir}/flac
eval cmake "${root}/flac-1.3.1" ${common_args}
make install ${parallel}
