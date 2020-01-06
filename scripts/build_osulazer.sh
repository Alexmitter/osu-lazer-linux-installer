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
	clear
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

	dotnet restore osu.sln
	#dotnet build -c Release osu.sln
	dotnet build -c Release osu.Desktop

	if [ $? -ne 0 ]; then
		echo -e "\n\n\nBUILD  Process Failed\nIf building the daily build fails,\n please report that as a issue on https://github.com/Alexmitter/osu-lazer-linux-installer";
		read -p "Press Enter to return";
	fi
	
	cd ../..
	bash start.sh
}

GetStable()
{
	clear
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
	
	dotnet restore osu.sln
	#dotnet build -c Release osu.sln
	dotnet build -c Release osu.Desktop
	
	if [ $? -ne 0 ]; then
		echo -e "\n\n\nBUILD  Process Failed\nAs you selected Stable, it may that the build hash you selected may be too old to work\nPlease try the daily build,\nif it also fails, please report it on https://github.com/Alexmitter/osu-lazer-linux-installer";
		read -p "Press Enter to return";
	fi
	
	cd ../..
	bash start.sh

}

ManualVersion()
{
	clear
	echo "Input the commit hash of your choice"
	echo "How to: https://www.youtube.com/watch?v=woHu_nZZH18"
	read -p "Enter hash: " HASH
}

ChooseStable()
{
	HEIGHT=15
	WIDTH=40
	CHOICE_HEIGHT=4
	BACKTITLE="osu lazer installer"
	TITLE="Choose Version  ---  Warning: The preset git hash can break, if it does not work, try a manual hash"
	MENU="Choose one of the following options:"

	OPTIONS=(1 "2020.104.0" 2 "Manual")

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
			HASH=" 62a780a"
	    ;;
        2)
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
