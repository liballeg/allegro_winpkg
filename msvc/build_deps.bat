set root=%cd%

cd %root%\zlib-1.2.8 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cd %root%\physfs-2.0.3 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output -DPHYSFS_BUILD_TEST=off || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo || goto :error

cd %root%\dumb-0.9.3 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cd %root%\freetype-2.5.5 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cd %root%\libjpeg-turbo-1.4.0 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output -DWITH_TURBOJPEG=false  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cd %root%\libpng-1.6.17 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config Release  || goto :error

cd %root%\libogg-1.3.2 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cd %root%\libvorbis-1.3.5 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cd %root%\libtheora-1.1.1 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cd %root%\flac-1.3.1 || goto :error
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../../output  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

goto :success

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

:success
cd %root%
