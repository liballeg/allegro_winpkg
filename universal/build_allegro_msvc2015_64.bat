setlocal
set deps=%cd%\allegro_deps-msvc2015-x64\allegro_deps
set output=%cd%\allegro-msvc2015-x64\allegro
set generator=-G "Visual Studio 14 2015 Win64"
set toolchain=-T v140_xp
set build_dir=%cd%\build_msvc2015_64

call build_allegro_msvc.bat
