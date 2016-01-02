#!/bin/bash

# TODO: There must be a better way...
if [ "${MSYSTEM}" != MINGW64 ]
then
	echo 'Needs to be run from 64 bit shell'
	exit -1
fi

export DXSDK_DIR=/mingw64/x86_64-w64-mingw32
./build_allegro_msys.sh "MSYS Makefiles" build_msys_64 allegro_deps_msys_64 allegro_msys_64
