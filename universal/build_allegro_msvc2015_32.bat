setlocal
set deps=%cd%\allegro_deps-msvc2015-x86\allegro_deps
set output=%cd%\allegro-msvc2015-x86\allegro
set generator=-G "Visual Studio 14 2015"
set toolchain=-T v140
set build_dir=%cd%\build_msvc2015_32

call build_allegro_msvc.bat
