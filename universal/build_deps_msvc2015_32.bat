setlocal 
set output=%cd%\allegro_deps-msvc2015-x86\allegro_deps
set generator=-G "Visual Studio 14 2015"
set toolchain=-T v140_xp
set build_dir=%cd%\build_msvc2015_32

call build_deps_msvc.bat
