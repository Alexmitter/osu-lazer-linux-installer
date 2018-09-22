#/bin/bash

cd osu
dotnet publish --self-contained --configuration Release --runtime ubuntu.16.10-x64
echo your game package will be under /osu/osu.Desktop/bin/Release/netcoreapp2.1

