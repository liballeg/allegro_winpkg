Requirements:

- MSVC 2013 or 2015 (if you're using something else, you'll need to 
  edit the scripts mentioned below. You'll need to rename the generator 
  and the toolchain.)
- nasm (put this in PATH)
- cmake (put this in PATH)
- DXSDK (optional, but required for advanced features)

To build the dependencies, run build_deps_msvc{msvc_version}_{bits}.bat 
where {msvc_version} is your MSVC version (2013 or 2015) and {bits} is 
32 or 64. This will place the outputs (headers, static libraries) 
inside allegro_deps-msvc{msvc_version}-x{bits} directory.

To build Allegro, extract Allegro's source into a subdirectory named 
'allegro' and then run build_allegro_msvc{msvc_version}_{bits}.bat. 
This will place the outputs inside the 
allegro-msvc{msvc_version}-x{bits} directory.
