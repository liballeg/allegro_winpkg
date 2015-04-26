Requirements:

- MSVC 2013 (if you're using something else, you'll need to edit the scripts
  mentioned below. You'll need to rename the generator and the toolchain.)
- nasm (put this in PATH)
- cmake (put this in PATH)
- DXSDK (optional, but required for advanced features)

To build the dependencies, run build_deps_32.bat (for 32 bit binaries) and/or
build_deps_64.bat (for 64 bit binaries). This will place the outputs (headers,
dlls and import/static libraries) inside deps_output_32 and deps_output_64
respectively.

To build Allegro, extract Allegro's source into a subdirectory named 'allegro'
and then run build_allegro_32.bat and/or build_allegro_64.bat (again, 32 and 64
bit respectively). This will place the outputs inside the allegro_output_32 and
allegro_output_64 respectively.
