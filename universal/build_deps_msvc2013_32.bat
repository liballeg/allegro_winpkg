setlocal 
set output=%cd%\allegro_deps-msvc2013-x86\allegro_deps
set generator=-G "Visual Studio 12 2013"
set toolchain=-T v120_xp
set build_dir=%cd%\build_msvc2013_32

call build_deps_msvc.bat
