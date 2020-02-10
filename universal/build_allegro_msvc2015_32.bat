setlocal
set deps=%cd%\allegro_deps-msvc2015-x86\allegro_deps
set output=%cd%\allegro-msvc2015-x86\allegro
set generator=-G "Visual Studio 16 2019" -A Win32
set toolchain=-T v141_xp
set build_dir=%cd%\build_msvc2015_32

call build_allegro_msvc.bat
