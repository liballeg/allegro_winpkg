setlocal
set output=%cd%\allegro_deps-msvc2022-x86\allegro_deps
set generator=-G "Visual Studio 17 2022" -A Win32
set toolchain=-T v141_xp
set build_dir=%cd%\build_msvc2022_32

call build_deps_msvc.bat
