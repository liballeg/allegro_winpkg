setlocal
set root=%cd%
set jobs=16

rem echo ***** 32-bit MSVC 2013 Build *****
rem set toolchain=-T v120_xp
rem set generator=-G "Visual Studio 12 2013"
rem set buildroot=%root%\nupkg\v120\win32
rem call :build_all
rem 
rem echo ***** 64-bit MSVC 2013 Build *****
rem set toolchain=-T v120_xp
rem set generator=-G "Visual Studio 12 2013 Win64"
rem set buildroot=%root%\nupkg\v120\x64
rem call :build_all

rem echo ***** 32-bit MSVC 2015 Build *****
rem set toolchain=-T v140_xp
rem set generator=-G "Visual Studio 14 2015"
rem set buildroot=%root%\nupkg\v140\win32
rem call :build_all
rem 
rem echo ***** 64-bit MSVC 2015 Build *****
rem set toolchain=-T v140_xp
rem set generator=-G "Visual Studio 14 2015 Win64"
rem set buildroot=%root%\nupkg\v140\x64
rem call :build_all

rem echo ***** 32-bit MSVC 2017 Build *****
rem set toolchain=-T v141_xp
rem set generator=-G "Visual Studio 16 2019" -A Win32
rem set buildroot=%root%\nupkg\v141\win32
rem call :build_all
rem
rem echo ***** 64-bit MSVC 2017 Build *****
rem set toolchain=-T v141_xp
rem set generator=-G "Visual Studio 16 2019" -A x64
rem set buildroot=%root%\nupkg\v141\x64
rem call :build_all
rem
rem echo ***** 32-bit MSVC 2019 Build *****
rem set toolchain=-T v142
rem set generator=-G "Visual Studio 16 2019" -A Win32
rem set buildroot=%root%\nupkg\v142\win32
rem call :build_all
rem
rem echo ***** 64-bit MSVC 2019 Build *****
rem set toolchain=-T v142
rem set generator=-G "Visual Studio 16 2019" -A x64
rem set buildroot=%root%\nupkg\v142\x64
rem call :build_all
rem
rem echo ***** 32-bit MSVC 2019 Build *****
rem set toolchain=-T ClangCL
rem set generator=-G "Visual Studio 16 2019" -A Win32
rem set buildroot=%root%\nupkg\ClangCL\win32
rem call :build_all
rem
rem echo ***** 64-bit MSVC 2019 Build *****
rem set toolchain=-T ClangCL
rem set generator=-G "Visual Studio 16 2019" -A x64
rem set buildroot=%root%\nupkg\ClangCL\x64
rem call :build_all

echo ***** 32-bit MSVC 2022 Build *****
set toolchain=-T v142
set generator=-G "Visual Studio 17 2022" -A Win32
set buildroot=%root%\nupkg\v142\win32
call :build_all

echo ***** 64-bit MSVC 2022 Build *****
set toolchain=-T v142
set generator=-G "Visual Studio 17 2022" -A x64
set buildroot=%root%\nupkg\v142\x64
call :build_all

echo ***** 32-bit MSVC 2022 Build *****
set toolchain=-T v143
set generator=-G "Visual Studio 17 2022" -A Win32
set buildroot=%root%\nupkg\v143\win32
call :build_all

echo ***** 64-bit MSVC 2022 Build *****
set toolchain=-T v143
set generator=-G "Visual Studio 17 2022" -A x64
set buildroot=%root%\nupkg\v143\x64
call :build_all

echo ***** 32-bit MSVC 2022 Build *****
set toolchain=-T ClangCL
set generator=-G "Visual Studio 17 2022" -A Win32
set buildroot=%root%\nupkg\ClangCL\win32
call :build_all

echo ***** 64-bit MSVC 2022 Build *****
set toolchain=-T ClangCL
set generator=-G "Visual Studio 17 2022" -A x64
set buildroot=%root%\nupkg\ClangCL\x64
call :build_all

rem ***** Make NUGET Package *****
cd %root%
nuget pack Allegro.nuspec
nuget pack AllegroDeps.nuspec

endlocal
goto :EOF

:build_all
rem Build Allegro and the dependencies
rem **** Static dependencies **** 
set shared=no
call :makedeps
rem **** Static Monolith Allegro ****
set monolith=yes
set shared=no
set build_type=RelWithDebInfo
set static_runtime=yes
call :allegro
rem **** Dynamic Allegro ****
set monolith=no
set shared=yes
set build_type=RelWithDebInfo
set static_runtime=yes
call :allegro
REM ~ rem **** Debug Allegro ****
set monolith=no
set shared=yes
set build_type=Debug
set static_runtime=no
call :allegro

goto :EOF

:allegro
rem Build Allegro
mkdir "%buildroot%\allegro"
echo ***** Building Allegro shared=%shared% *****
set args=%generator% %toolchain% -DCMAKE_PREFIX_PATH="%buildroot%\deps" -DCMAKE_INSTALL_PREFIX="%buildroot%"
set args=%args% -DWANT_MONOLITH=%monolith% -DSHARED=%shared% -DWANT_STATIC_RUNTIME=%static_runtime% -DCMAKE_BUILD_TYPE=%build_type%
set args=%args% -DWANT_NATIVE_IMAGE_LOADER=off -DWANT_EXAMPLES=off -DWANT_TESTS=off -DWANT_DEMO=off -DWANT_ACODEC_DYNAMIC_LOAD=off -DFLAC_STATIC=on -DFREETYPE_ZLIB=on -DFREETYPE_PNG=on -DOPENMPT_ZLIB=on -DOPENMPT_VORBIS=on
cd %buildroot%\allegro
cmake  %args% "%root%\allegro" || goto :error
cmake --build . --target INSTALL --config %build_type% -j %jobs% || goto :error

goto :EOF

:makedeps

rem Build all the dependencies
set args=%generator% %toolchain% -DCMAKE_PREFIX_PATH="%buildroot%\deps" -DCMAKE_INSTALL_PREFIX="%buildroot%\deps"

mkdir "%buildroot%\deps\include"
copy "%root%\minimp3\*.h" "%buildroot%\deps\include"

call :makedep zlib-1.3
call :makedep libpng-1.6.40
call :makedep freetype-2.13.2 "-DFT_DISABLE_HARFBUZZ=TRUE" "-DFT_DISABLE_HARFBUZZ=TRUE" "-DFT_DISABLE_BROTLI=TRUE"
call :makedep libjpeg-turbo-3.0.0 "-DWITH_TURBOJPEG=false" "-DENABLE_SHARED=false"
call :makedep physfs-3.0.2 "-DPHYSFS_BUILD_TEST=off"
call :makedep dumb-2.0.3 "-DBUILD_EXAMPLES=off" "-DBUILD_ALLEGRO4=off"
call :makedep libogg-1.3.5
call :makedep libvorbis-1.3.7
call :makedep libtheora-1.1.1
call :makedep flac-1.4.3
call :makedep opus-1.4
call :makedep opusfile-0.12
call :makedep libwebp-1.3.2 "-DWEBP_BUILD_ANIM_UTILS=off" "-DWEBP_BUILD_CWEBP=off" "-DWEBP_BUILD_DWEBP=off" ^
	 "-DWEBP_BUILD_GIF2WEBP=off" "-DWEBP_BUILD_IMG2WEBP=off" "-DWEBP_BUILD_VWEBP=off" "-DWEBP_BUILD_WEBPINFO=off" "-DWEBP_BUILD_WEBPMUX=off" ^
	 "-DWEBP_BUILD_EXTRAS=off" "-DWEBP_BUILD_LIBWEBPMUX=off"
call :makedep libopenmpt-0.7.11
goto :EOF

:makedep
set dep_name=%1
shift
echo ***** Building Dependency %dep_name% *****
mkdir "%buildroot%\%dep_name%"
cd %buildroot%\%dep_name%
cmake  %args% %* "%root%\%dep_name%"  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo -j %jobs% || goto :error
goto :EOF

:error
@echo Failed with error #%errorlevel%.
exit /b %errorlevel%
