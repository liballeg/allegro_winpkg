setlocal
set deps=%cd%\allegro_deps-msvc2022-x64\allegro_deps
set output=%cd%\allegro-msvc2022-x64\allegro
set generator=-G "Visual Studio 17 2022" -A x64
set toolchain=-T v143
set build_dir=%cd%\build_msvc2022_64

call build_allegro_msvc.bat