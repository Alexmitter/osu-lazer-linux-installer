#/bin/bash

echo osu!lazer installer for linux

sudo rm -r ~/osu

mkdir ~/osu
cd ~/osu

git clone https://github.com/ppy/osu.git
cd osu/
git submodule update --init


dotnet restore
dotnet build
cd osu.Desktop
dotnet run
