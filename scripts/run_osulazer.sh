#!/bin/bash

RunDaily()
{
	#Check if it it exists

	cd osu-daily/osu.Desktop
	dotnet run
}

RunStable()
{
	#Check if it exists
	
	cd osu-stable/osu.Desktop
	dotnet run
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
			RunStable
            ;;
        2)
			RunDaily
            ;;
        *)
			echo "Error: impossible choice"
			exit 1
			;;
         
	esac
}

Choose
echo "Done"
