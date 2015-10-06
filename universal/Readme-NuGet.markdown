Instructions for NuGet Packaging
================================

1. Download the `nuget.exe` standalone file and the NuGet integration for Visual Studio from the [official site][1]
2. Make sure `nuget.exe` is on your path
3. Tweak the build scripts (32 and 64 bit to suit your install)
4. Run `build_nuget.cmd` (this does all the cmake config and build)
5. Set up a local directory for your Nuget packages.
6. Copy the generated `Allegro.5.1.12.nupkg` to it.
(In the future, upload to the NuGet package repository)


Using NuGet Package
===================

1. Create a new empty Win32 Project
2. In Project menu, go to Manage NuGet Packages and add Allegro
3. Write your program - it will be dynamically linked for 32 or 64 bit projects.
4. If you are using addons, go to the project (not solution) properties, Allegro section and choose addons from the dropdowns.

[1]: https://www.nuget.org/