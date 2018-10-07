#/bin/bash

echo osu!lazer installer for linux

echo The script will remove the osu folder in your home folder if existing


git clone https://github.com/ppy/osu.git
cd osu/
git submodule update --init


dotnet restore
dotnet build -c Release

echo DONE
