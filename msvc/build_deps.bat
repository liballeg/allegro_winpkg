set root=%cd%
set common_args=-G %generator% -T %toolchain% -DCMAKE_INSTALL_PREFIX=%output%

mkdir %build_dir%

mkdir %build_dir%\zlib
cd %build_dir%\zlib
cmake %root%\zlib-1.2.8 %common_args%  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

mkdir %build_dir%\physfs
cd %build_dir%\physfs
cmake %root%\physfs-2.0.3 %common_args% -DPHYSFS_BUILD_TEST=off || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo || goto :error

mkdir %build_dir%\dumb
cd %build_dir%\dumb
cmake %root%\dumb-0.9.3 %common_args%  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

mkdir %build_dir%\freetype
cd %build_dir%\freetype
cmake %root%\freetype-2.5.5 %common_args%  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

mkdir %build_dir%\libjpeg-turbo
cd %build_dir%\libjpeg-turbo
cmake %root%\libjpeg-turbo-1.4.0 %common_args% -DWITH_TURBOJPEG=false  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

mkdir %build_dir%\libpng
cd %build_dir%\libpng
cmake %root%\libpng-1.6.17 %common_args%  || goto :error
cmake --build . --target INSTALL --config Release  || goto :error

mkdir %build_dir%\libogg
cd %build_dir%\libogg
cmake %root%\libogg-1.3.2 %common_args%  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

mkdir %build_dir%\libvorbis
cd %build_dir%\libvorbis
cmake %root%\libvorbis-1.3.5 %common_args%  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

mkdir %build_dir%\libtheora
cd %build_dir%\libtheora
cmake %root%\libtheora-1.1.1 %common_args%  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

mkdir %build_dir%\flac
cd %build_dir%\flac
cmake %root%\flac-1.3.1 %common_args%  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

goto :success

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

:success
cd %root%
