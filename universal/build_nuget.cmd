setlocal
set root=%cd%
set toolchain=-T v140_xp

echo ***** 32-bit MSVC 2015 Build *****
set generator=-G "Visual Studio 14 2015"
set buildroot=%root%\nupkg\32\v140
call :build_all

echo ***** 64-bit MSVC 2015 Build *****
set generator=-G "Visual Studio 14 2015 Win64"
set buildroot=%root%\nupkg\64\v140
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
rem **** Debug Allegro ****
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
set args=%generator% %toolchain% -DCMAKE_PREFIX_PATH="%buildroot%" -DCMAKE_INSTALL_PREFIX="%buildroot%"
set args=%args% -DWANT_MONOLITH=%monolith% -DSHARED=%shared% -DWANT_STATIC_RUNTIME=%static_runtime% -DCMAKE_BUILD_TYPE=%build_type%
set args=%args% -DWANT_EXAMPLES=off -DWANT_TESTS=off -DWANT_DEMO=off -DWANT_ACODEC_DYNAMIC_LOAD=off -DFLAC_STATIC=on
cd %buildroot%\allegro
cmake  %args% "%root%\allegro" || goto :error
cmake --build . --target INSTALL --config %build_type% || goto :error

goto :EOF

:makedeps

rem Build all the dependencies
set args=%generator% %toolchain% -DCMAKE_PREFIX_PATH="%buildroot%" -DCMAKE_INSTALL_PREFIX="%buildroot%"

call :makedep zlib-1.2.8
call :makedep dumb-0.9.3
call :makedep freetype-2.5.5
call :makedep libjpeg-turbo-1.4.0 "-DWITH_TURBOJPEG=false"
call :makedep libpng-1.6.17
call :makedep libogg-1.3.2
call :makedep libvorbis-1.3.5
call :makedep libtheora-1.1.1
call :makedep flac-1.3.1 
call :makedep physfs-2.0.3 "-DPHYSFS_BUILD_TEST=no"
goto :EOF

:makedep
echo ***** Building Dependency %1 *****
mkdir "%buildroot%\%1"
cd %buildroot%\%1
cmake  %args% %2 "%root%\%1"  || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error
goto :EOF

:error
@echo Failed with error #%errorlevel%.
exit /b %errorlevel%
