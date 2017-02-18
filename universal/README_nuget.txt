Requirements:

- MSVC 2013 and 2015 (if you're using something else, you'll need to 
  edit the nuget script mentioned below. You'll need to rename the generator 
  and the toolchain.)
- nasm (put this in PATH)
- cmake (put this in PATH)
- nuget (put this in PATH)
- DXSDK (optional, but required for advanced features)
- python

Then, you typically want to run create_nuspec with the versions you want to support, e.g.:

    python create_nuspec.py --allegro_version 5.2.3.0 --allegro_deps_version 1.5.0.0 --toolchains v120,v140

And then run `create_nuget.cmd`. It will produce the `Allegro<version>.nupkg` and `AllegroDeps<version>.nupkg`.
