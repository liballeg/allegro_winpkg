echo off
setlocal
set generator=
set root=%cd%

echo ***** 32-bit Build *****
set toolchain=
set buildroot=%root%\nupkg\32
rem **** Static dependencies **** 
set shared=no
call :makedeps
rem **** Static Allegro ****
set monolith=yes
set shared=no
call :allegro
rem **** Dynamic Allegro ****
set monolith=no
set shared=yes
call :allegro


echo ***** 64-bit Build *****
set toolchain=-A x64
set buildroot=%root%\nupkg\64
rem **** Static dependencies **** 
set shared=no
call :makedeps
rem **** Static Allegro ****
set monolith=yes
set shared=no
call :allegro
rem **** Dynamic Allegro ****
set monolith=no
set shared=yes
call :allegro

rem ***** Make NUGET Package *****
cd %root%
nuget pack Allegro.nuspec
nuget pack AllegroDeps.nuspec

endlocal
goto :EOF

:allegro
mkdir "%buildroot%\allegro"
echo ***** Building Allegro shared=%shared% *****
set args=%toolchain% -DCMAKE_PREFIX_PATH="%buildroot%" -DCMAKE_INSTALL_PREFIX="%buildroot%"
set args=%args% -DWANT_MONOLITH=%monolith% -DSHARED=%shared% -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=RelWithDebInfo
set args=%args% -DWANT_EXAMPLES=off -DWANT_TESTS=off -DWANT_DEMO=off -DWANT_ACODEC_DYNAMIC_LOAD=off -DFLAC_STATIC=on
cd %buildroot%\allegro
cmake  %args% "%root%\allegro" || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

goto :EOF

:makedeps

set args=%toolchain% -DCMAKE_PREFIX_PATH="%buildroot%" -DCMAKE_INSTALL_PREFIX="%buildroot%"

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
