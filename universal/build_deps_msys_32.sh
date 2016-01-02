#!/bin/bash

# TODO: There must be a better way...
if [ "${MSYSTEM}" != MINGW32 ]
then
	echo 'Needs to be run from 32 bit shell'
	exit -1
fi

./build_deps_msys.sh "MSYS Makefiles" build_msys_32 allegro_deps_msys_32
