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
parallel=-j8

common_args="-DCMAKE_PREFIX_PATH=\"${output_dir}\" -DCMAKE_INSTALL_PREFIX=\"${output_dir}\""
if [ -n "$generator" ]
then
	common_args="${common_args} -G \"${generator}\""
fi

set -x
set -e

mkdir -p "${build_dir}/zlib"
cd "${build_dir}/zlib"
eval cmake "${root}/zlib-1.2.11" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libpng"
cd ${build_dir}/libpng
eval cmake "${root}/libpng-1.6.36" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/freetype"
cd "${build_dir}/freetype"
#~ eval cmake "${root}/freetype-2.8" ${common_args} -DWITH_HarfBuzz=OFF -DWITH_BZip2=OFF
eval cmake "${root}/freetype-2.9.1" ${common_args} -DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz=TRUE -DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE
make install ${parallel}

mkdir -p "${build_dir}/libjpeg-turbo"
cd "${build_dir}/libjpeg-turbo"
eval cmake "${root}/libjpeg-turbo-2.0.1" ${common_args} -DWITH_TURBOJPEG=false -DENABLE_SHARED=false
make install ${parallel}

mkdir -p "${build_dir}/physfs"
cd "${build_dir}/physfs"
eval cmake "${root}/physfs-3.0.1" ${common_args} -DPHYSFS_BUILD_TEST=off
make install ${parallel}

mkdir -p "${build_dir}/dumb"
cd "${build_dir}/dumb"
eval cmake "${root}/dumb-2.0.3" ${common_args} -DBUILD_EXAMPLES=off -DBUILD_ALLEGRO4=off
make install ${parallel}

mkdir -p "${build_dir}/libogg"
cd ${build_dir}/libogg
eval cmake "${root}/libogg-1.3.3" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libvorbis"
cd ${build_dir}/libvorbis
eval cmake "${root}/libvorbis-1.3.6" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libtheora"
cd ${build_dir}/libtheora
eval cmake "${root}/libtheora-1.1.1" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/flac"
cd ${build_dir}/flac
eval cmake "${root}/flac-1.3.2" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/opus"
cd ${build_dir}/opus
eval cmake "${root}/opus-1.3" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/opusfile"
cd ${build_dir}/opusfile
eval cmake "${root}/opusfile-0.11" ${common_args}
make install ${parallel}

mkdir -p "${build_dir}/libwebp"
cd ${build_dir}/libwebp
eval cmake "${root}/libwebp-1.0.2" ${common_args} -DWEBP_BUILD_ANIM_UTILS=off -DWEBP_BUILD_CWEBP=off -DWEBP_BUILD_DWEBP=off \
	-DWEBP_BUILD_GIF2WEBP=off -DWEBP_BUILD_IMG2WEBP=off -DWEBP_BUILD_VWEBP=off -DWEBP_BUILD_WEBPINFO=off -DWEBP_BUILD_WEBPMUX=off \
	-DWEBP_BUILD_EXTRAS=off
make install ${parallel}