# osu-lazer-linux-installer

Dependencies are: dotnet core sdk (currently 2.1.4)

Get it from https://www.microsoft.com/net/download

Execution Order:
- build_osulazer.sh
- run_osulazer.sh

Optional if you want a linux binarx package, run makepkg_osulazer.sh

The script will create a "osu" folder in your User Home Folder.

The Build Script will remove it and clone/build everything again.

Those scripts may be very bad practice, feel free to edit and commit a change.
