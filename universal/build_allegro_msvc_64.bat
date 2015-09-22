setlocal
set deps=%cd%\allegro_deps-msvc2013-x64\allegro_deps
set output=%cd%\allegro-msvc2013-x64\allegro
set generator=-G "Visual Studio 12 2013 Win64"
set toolchain=-T v120_xp
set build_dir=%cd%\build_msvc_64

call build_allegro_msvc.bat
