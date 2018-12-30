#!/bin/bash

patch()
{
	string=$(dotnet --version)
	
	case "$string" in 
	*2.1.*)
		echo "INFO: Dotnet 2.1 detected, will patch csproj files"
		#Will change the netcoreapp varibale in all .csproj 
		find . -name '*.csproj' -print0 | xargs -0 sed -i 's/netcoreapp2.2/netcoreapp2.1/g'
    ;;
	esac
	
}

GetDaily()
{
	#Check if it exists, if, warn and remove if accepted
	if [ -d "osu-daily/" ]; then
		cd scripts/
		dialog --title "$OLDOSUFOUND" --backtitle "$BUILDNEWASK" --yesno "$SURETODELETE" 7 60
		response=$?
		case $response in
			0) sudo rm -r osu-daily/;;
			1) echo "$OSUNOTREMOVED"
			exit;;
			255) echo "$ESCPRESSED"
			exit;;	
		esac
	fi
	
	
	echo "osu!lazer installer for linux"

	echo "This script will clone osu!lazer and build it."


	git clone --recurse-submodules https://github.com/ppy/osu.git osu-daily
	cd osu-daily/
	patch

	dotnet restore
	dotnet build -c Release

	echo DONE
}

GetStable()
{
	#Check if it exists, if, warn and remove if accepted
	if [ -d "osu-stable/" ]; then
		cd scripts/
		dialog --title "$OLDOSUFOUND" --backtitle "$BUILDNEWASK" --yesno "$SURETODELETE" 7 60
		response=$?
		case $response in
			0) sudo rm -r osu-stable/;;
			1) echo "$OSUNOTREMOVED"
			exit;;
			255) echo "$ESCPRESSED"
			exit;;
		esac
	fi
	
	echo "osu!lazer installer for linux"

	echo "This script will clone osu!lazer and build it."
	
	git clone --recurse-submodules https://github.com/ppy/osu.git osu-stable
	cd osu-stable/
	if [ -z "$HASH" ]; then
		echo "ERROR: No Hash to checkout to"
	fi
	git checkout $HASH .
	patch
	
	dotnet restore
	dotnet build -c Release
}

ManualVersion()
{
	clear
	echo "Input the commit hash of your choice"
	read -p "Enter hash: " HASH
}

ChooseStable()
{
	HEIGHT=15
	WIDTH=40
	CHOICE_HEIGHT=4
	BACKTITLE="osu lazer installer"
	TITLE="Choose Version"
	MENU="Choose one of the following options:"

	OPTIONS=(1 "2018.1228" 2 "2018.1227" 3 "2018.1227" 4 "Manual")

	CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

	clear
	case $CHOICE in
        1)
			HASH="1b35eae"
            ;;
        2)
			HASH="f21b784"
            ;;
        3)
			HASH="c818e1c"
            ;;
        4)
			ManualVersion
            ;;
        *)
			echo "Error: impossible choice"
			exit 1
			;;
         
	esac
	GetStable
}

Choose()
{
	HEIGHT=15
	WIDTH=40
	CHOICE_HEIGHT=4
	BACKTITLE="osu lazer installer"
	TITLE="Choose Version"
	MENU="Choose one of the following options:"

	OPTIONS=(1 "Stable"
         2 "Daily")

	CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

	clear
	case $CHOICE in
        1)
			ChooseStable
            ;;
        2)
			GetDaily
            ;;
        *)
			echo "Error: impossible choice"
			exit 1
			;;
         
	esac
}

. ./../language/"$GLOBLANG".sh
echo "Run build script"
Choose
