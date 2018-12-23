#/bin/bash

patch()
{
	string=$(dotnet --version)
	
	case "$string" in 
	*2.1*)
		echo "INFO: Dotnet 2.1 detected, will patch csproj files"
		#Will change the netcoreapp varibale in all .csproj 
		find . -name '*.csproj' -print0 | xargs -0 sed -i 's/netcoreapp2.2/netcoreapp2.1/g'
    ;;
	esac
	
}

echo osu!lazer installer for linux

echo This script will clone osu!lazer and build it.


git clone --recurse-submodules https://github.com/ppy/osu.git
cd osu/
#git submodule update --init

patch
#find . -name '*.csproj' -print0 | xargs -0 sed -i 's/netcoreapp2.2/netcoreapp2.1/g' #To Compile since a change on osu's side need dotnet 2.1

dotnet restore
dotnet build -c Release

echo DONE
