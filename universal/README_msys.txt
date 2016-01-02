Requirements:

- MSYS (tested with MSYS2)
- gcc
- nasm (put this in PATH)
- cmake

To build the dependencies, run build_deps_msys_{bits}.sh {bits} is 32 or 64 
from the corresponding shell. This will place the outputs (headers, static 
libraries) inside allegro_deps_msys_{bits} directory.

To build Allegro, extract Allegro's source into a subdirectory named 'allegro' 
and then run build_allegro_msys_{bits}.sh. This will place the outputs inside 
the allegro_msys_{bits} directory.
