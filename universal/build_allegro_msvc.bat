if not defined build_dir goto :nodirect

set root=%cd%
set common_args=-G %generator% -T %toolchain% -DCMAKE_PREFIX_PATH=%deps% -DCMAKE_INSTALL_PREFIX=%output% -DWANT_EXAMPLES=off -DWANT_TESTS=off -DWANT_DEMO=off

mkdir "%build_dir%\allegro"
cd "%build_dir%\allegro"

cmake "%root%\allegro" -DWANT_MONOLITH=off -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=RelWithDebInfo %common_args% || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error
cmake "%root%\allegro" -DWANT_MONOLITH=on -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error
cmake "%root%\allegro" -DWANT_MONOLITH=off -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error
cmake "%root%\allegro" -DWANT_MONOLITH=on -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cmake "%root%\allegro" -DWANT_MONOLITH=off -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=Debug
cmake --build . --target INSTALL --config Debug  || goto :error
cmake "%root%\allegro" -DWANT_MONOLITH=on -DSHARED=on -DWANT_STATIC_RUNTIME=off -DCMAKE_BUILD_TYPE=Debug
cmake --build . --target INSTALL --config Debug  || goto :error
::~ cmake %root%\allegro -DWANT_MONOLITH=off -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=Debug
::~ cmake --build . --target INSTALL --config Debug  || goto :error
::~ cmake %root%\allegro -DWANT_MONOLITH=on -DSHARED=off -DWANT_STATIC_RUNTIME=on -DCMAKE_BUILD_TYPE=Debug
::~ cmake --build . --target INSTALL --config Debug  || goto :error

goto :success

:error
@echo Failed with error #%errorlevel%.
exit /b %errorlevel%

:nodirect
@echo Failed : Use build_allegro_msvc_32 or build_allegro_msvc_64

:success

