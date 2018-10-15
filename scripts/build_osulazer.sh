#/bin/bash

echo osu!lazer installer for linux

echo This script will clone osu!lazer and build it.


git clone https://github.com/ppy/osu.git
cd osu/
git submodule update --init


dotnet restore
dotnet build -c Release

echo DONE
