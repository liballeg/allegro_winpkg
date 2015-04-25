set root=%cd%

cd %root%\allegro || goto :error
mkdir build
cd build

cmake .. -DWANT_MONOLITH=off -DSHARED=on -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=../../output -DWANT_EXAMPLES=off -DWANT_TESTS=off -DWANT_DEMO=off || goto :error
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error
cmake .. -DWANT_MONOLITH=on -DSHARED=on -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error
cmake .. -DWANT_MONOLITH=off -DSHARED=off -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error
cmake .. -DWANT_MONOLITH=on -DSHARED=off -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo  || goto :error

cmake .. -DWANT_MONOLITH=off -DSHARED=on -DCMAKE_BUILD_TYPE=Debug
cmake --build . --target INSTALL --config Debug  || goto :error
cmake .. -DWANT_MONOLITH=on -DSHARED=on -DCMAKE_BUILD_TYPE=Debug
cmake --build . --target INSTALL --config Debug  || goto :error
cmake .. -DWANT_MONOLITH=off -DSHARED=off -DCMAKE_BUILD_TYPE=Debug
cmake --build . --target INSTALL --config Debug  || goto :error
cmake .. -DWANT_MONOLITH=on -DSHARED=off -DCMAKE_BUILD_TYPE=Debug
cmake --build . --target INSTALL --config Debug  || goto :error

goto :success

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%

:success
cd %root%
