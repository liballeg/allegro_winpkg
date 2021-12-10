setlocal
set output=%cd%\allegro_deps-msvc2022-x64\allegro_deps
set generator=-G "Visual Studio 17 2022" -A x64
set toolchain=-T v143
set build_dir=%cd%\build_msvc2022_64

call build_deps_msvc.bat
