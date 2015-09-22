setlocal
set output=%cd%\allegro_deps-msvc2013-x64\allegro_deps
set generator="Visual Studio 12 2013 Win64"
set toolchain=v120_xp
set build_dir=%cd%\build_msvc_64

call build_deps_msvc.bat
