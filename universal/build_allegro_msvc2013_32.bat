setlocal
set deps=%cd%\allegro_deps-msvc2013-x86\allegro_deps
set output=%cd%\allegro-msvc2013-x86\allegro
set generator=-G "Visual Studio 12 2013"
set toolchain=-T v120_xp
set build_dir=%cd%\build_msvc2013_32

call build_allegro_msvc.bat
