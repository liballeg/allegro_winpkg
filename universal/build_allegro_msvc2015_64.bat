setlocal
set deps=%cd%\allegro_deps-msvc2015-x64\allegro_deps
set output=%cd%\allegro-msvc2015-x64\allegro
set generator=-G "Visual Studio 16 2019" -A x64
set toolchain=-T v141_xp
set build_dir=%cd%\build_msvc2015_64

call build_allegro_msvc.bat
