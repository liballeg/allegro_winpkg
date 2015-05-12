These directories contain the PKGBUILDs necessary to create Allegro packages
for mingw-w64.

Inside each directory, you can use the following commands to build the package.
Run all these from msys2_shell.bat.

First, you need to install some build dependencies:

pacman -S mingw-w64-x86_64-toolchain mingw-w64-i686-toolchain base-devel

May need to restart msys2_shell.bat and run autorebase.bat before restarting it
and continuing with the process.

Then run:

makepkg-mingw -os

This will download the Allegro source and ask you to install whatever build
dependencies it needs.

Then finally run:

makepkg-mingw

This may take awhile, but eventually should produce two compressed packages.
