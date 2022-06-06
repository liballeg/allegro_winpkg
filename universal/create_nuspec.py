# coding=utf8

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--allegro_version', default='5.2.8.0')
parser.add_argument('--allegro_deps_version', default='1.13.0.0')
parser.add_argument('--toolchains', default='v142,v143,ClangCL')
parser.add_argument('--bits', default='win32,x64')
ARGS = parser.parse_args()

ALLEGRO_NUSPEC_TEMPLATE = """<?xml version="1.0" encoding="utf-8"?>
<!-- automatically generated by create_nuspec.py -->
<package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd">
  <metadata>
    <id>Allegro</id>
    <version>{allegro_version}</version>
    <title>Allegro Game Programming Library</title>
    <authors>Allegro Developers</authors>
    <owners>Allegro Developers</owners>
    <license type="expression">Zlib</license>
    <projectUrl>http://liballeg.org/</projectUrl>
    <iconUrl>http://liballeg.org/images/alex.png</iconUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <description>Allegro 5 is a cross-platform library mainly aimed at video game and multimedia programming. It handles common, low-level tasks such as creating windows, accepting user input, loading data, drawing images, playing sounds, etc. and generally abstracting away the underlying platform. However, Allegro is not a game engine: you are free to design and structure your program as you like.</description>
    <releaseNotes>Please refer to the online release notes at http://liballeg.org/changes-5.2.html </releaseNotes>
    <copyright>Copyright © 2008-2021 the Allegro 5 Development Team</copyright>
    <language>en-GB</language>
    <tags>Native</tags>
    <dependencies>
      <group>
        <dependency id="AllegroDeps" version="[{allegro_deps_version}]" />
      </group>
    </dependencies>
  </metadata>
  <files>
<!-- include files (same for all versions) -->
    <file src="nupkg\\{include_toolchain}\\win32\\include\\**" target="build\\native\\include\\" />
<!-- additional targets and user interface definitions -->
    <file src="Allegro.targets" target="build\\native\\Allegro.targets" />
    <file src="AllegroDeps.targets" target="build\\native\\AllegroDeps.targets" />
    <file src="AllegroUI.xml" target="build\\native\\AllegroUI.xml" />
    {extra_files}
  </files>
</package>
"""

ALLEGRO_DEPS_NUSPEC_TEMPLATE = """<?xml version="1.0" encoding="utf-8"?>
<!-- automatically generated by create_nuspec.py -->
<package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd">
  <metadata>
    <id>AllegroDeps</id>
    <version>{allegro_deps_version}</version>
    <title>Allegro Dependencies Package</title>
    <authors>Allegro Developers</authors>
    <owners>Allegro Developers</owners>
    <license type="expression">Zlib</license>
    <projectUrl>http://liballeg.org/</projectUrl>
    <iconUrl>http://liballeg.org/images/alex.png</iconUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <description>This package contains the dependencies for Allegro 5. You should install the main Allegro package and this one will be automatically added as a dependency.</description>
    <releaseNotes>Please refer to the online release notes at http://liballeg.org/changes-5.2.html </releaseNotes>
    <copyright>Copyright © 2008-2021 the Allegro 5 Development Team</copyright>
    <language>en-GB</language>
    <tags>Native</tags>
  </metadata>
  <files>
<!-- include files (same for all versions) -->
    <file src="nupkg\\{include_toolchain}\\win32\\deps\\include\\**" target="build\\native\\include\\" />
<!-- additional targets and user interface definitions -->
    <file src="AllegroDeps.targets" target="build\\native\\AllegroDeps.targets" />
    {extra_files}
  </files>
</package>
"""

ALLEGRO_BASENAMES = [
	'allegro',
	'allegro_audio',
	'allegro_acodec',
	'allegro_color',
	'allegro_dialog',
	'allegro_font',
	'allegro_image',
	'allegro_main',
	'allegro_memfile',
	'allegro_physfs',
	'allegro_primitives',
	'allegro_ttf',
	'allegro_video',
]

DEPS_FILENAMES = [
	"dumb.lib",
	"FLAC.lib",
	"freetype.lib",
	"jpeg.lib",
	"libpng16.lib",
	"ogg.lib",
	"physfs.lib",
	"theoradec.lib",
	"vorbis.lib",
	"vorbisfile.lib",
	"zlib.lib",
	"opus.lib",
	"opusfile.lib",
	"webp.lib",
	"webpdecoder.lib",
	"webpdemux.lib",
]

def make_line(bits, version, dll_loc, filename):
	loc = '\\'.join([version, bits, dll_loc])
	from_path = '\\'.join(['nupkg', loc, filename])
	to_path = '\\'.join(['build', 'native', loc, ''])
	return '<file src="' + from_path + '" target="' + to_path + '" />'

toolchains = ARGS.toolchains.split(',')
allegro_lines = []
deps_lines = []
for version in toolchains:
	for bits in ARGS.bits.split(','):
		allegro_lines.append(make_line(bits, version, 'lib', 'allegro_monolith-static.lib'))
		for filename in DEPS_FILENAMES:
			deps_lines.append(make_line(bits, version, 'deps\\lib', filename))
		for basename in ALLEGRO_BASENAMES:
			for debug in ['-debug', '']:
				for dll in [('bin', '-5.2.dll'), ('lib', '.lib')]:
					filename = basename + debug + dll[1]
					allegro_lines.append(make_line(bits, version, dll[0], filename))
			filename = basename + '-debug.pdb'
			allegro_lines.append(make_line(bits, version, 'lib', filename))

allegro_nuspec = ALLEGRO_NUSPEC_TEMPLATE.format(
	allegro_version=ARGS.allegro_version,
	allegro_deps_version=ARGS.allegro_deps_version,
	extra_files='\n    '.join(allegro_lines),
	include_toolchain=toolchains[0]
	)

deps_nuspec = ALLEGRO_DEPS_NUSPEC_TEMPLATE.format(
	allegro_deps_version=ARGS.allegro_deps_version,
	extra_files='\n    '.join(deps_lines),
	include_toolchain=toolchains[0]
	)

with open('Allegro.nuspec', 'w') as f:
	f.write(allegro_nuspec)

with open('AllegroDeps.nuspec', 'w') as f:
	f.write(deps_nuspec)
