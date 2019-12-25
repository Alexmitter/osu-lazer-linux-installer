#!/bin/bash

RunDaily()
{
	#Check if it it exists

	cd osu-daily/osu.Desktop
	if (( $WAYLAND == 1 )); then
		SDL_VIDEODRIVER=wayland dotnet run
		echo Test Wayland Active
    else
		dotnet run
	fi
}

RunStable()
{
	#Check if it exists
	
	cd osu-stable/osu.Desktop
	if (( $WAYLAND == 1 )); then
		SDL_VIDEODRIVER=wayland dotnet run
		echo Test Wayland Active
    else
		dotnet run
	fi
}

Choose()
{
	HEIGHT=25
	WIDTH=75
	CHOICE_HEIGHT=4
	BACKTITLE="osu lazer installer"
	TITLE="Choose Version"
	MENU="Attention: Wayland is buggy, bugs may be:
	- Colors are not displaed right
	- There may be a unmovable black window left after closing osu!lazer on Gnome Shell, a restart of the session may be needed"

	OPTIONS=(1 "Daily"
				2 "Daily with Wayland"
         3 "Stable"
         4 "Stable with Wayland")

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
				WAYLAND=0;
				RunDaily
            ;;
        2)
				WAYLAND=1;
				RunDaily
				;;
        3)
				WAYLAND=0;
				RunStable
				;;
        4)
				WAYLAND=1;
				RunStable
            ;;
        *)
			cd ..
			bash start.sh;
			exit 1
			;;
         
	esac
}

Choose
echo "Done"
