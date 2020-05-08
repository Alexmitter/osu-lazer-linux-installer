#/bin/bash

checkifnewversion()
{
	if [ -d ".git" ]; then
		BRANCH="master"
		LAST_UPDATE=`git show --no-notes --format=format:"%H" $BRANCH | head -n 1`
		LAST_COMMIT=`git show --no-notes --format=format:"%H" origin/$BRANCH | head -n 1`

		git remote update
		if [ $LAST_COMMIT != $LAST_UPDATE ]; then			
			echo 'Not updated'
			HEIGHT=25
			WIDTH=95
			CHOICE_HEIGHT=4
			BACKTITLE="Update Available"
			TITLE="Update Available"
			MENU="A newer commit is available, would you like to update to it?"

			OPTIONS=(1 "Yes"
				2 "No")

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
					git pull
					bash start.sh
					;;
				2)
					echo "Update skipped";
					;;
				*)
					echo "Error"
					bash start.sh
					;; 
			esac
		else
			echo "No updates available"
		fi
	fi
}


function NewDepInstaller
{
	HEIGHT=25
	WIDTH=95
	CHOICE_HEIGHT=4
	BACKTITLE="osu lazer installer"
	TITLE="Depinstaller"
	MENU="Warning, this style of installing the dependencies is deprecated. 
	I will likely remove it in a future update as it is not really maintainable due to 
	changes from ppy regarding the wanted dotnet core version and how Microsoft handles their apt repo
	Look on https://github.com/Alexmitter/osu-lazer-linux-installer/wiki/Manual-Dependency-install"

	OPTIONS=(1 "Ubuntu 18.04"
         2 "Ubuntu 16.04"
         3 "Placeholder"
         4 "Placeholder")

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
			cd depscripts/ubuntu18.04
			sudo bash ubuntu18.04.sh
            ;;
        2)
			cd depscripts/ubuntu16.04
			sudo bash ubuntu16.04.sh
            ;;
        3)
            echo ##Placeholder
            ;;
        4)
            echo ##Placeholder
            ;;
        *)
			echo "Error: Distribution not selected"
			bash start.sh
			;;
         
	esac
	
	
}

if ! [ -x "$(command -v dialog)" ]; then
  echo 'Error: dialog not installed, it is required by the tool.' >&2
  exit 1
fi

case "$(openssl version)" in
    LibreSSL*) export CLR_OPENSSL_VERSION_OVERRIDE=47;;
    *);;
esac

checkifnewversion

if [ -e langsettings.txt ]; then
	SLANGUAGE=$(<langsettings.txt)
else


dialog --stdout --title "English is the officially supported language!" \
  --backtitle "Language" \
  --yesno "Yes: Use English, No:  Select one of the community created language packs!" 15 60

	if [ "$?" -eq 0 ]; then
		SLANGUAGE="english"
		dialog --msgbox "You can always reset your choice by deleting the created langsettings.txt file" 10 45
	else
		HEIGHT=15
		WIDTH=50
		CHOICE_HEIGHT=5
		BACKTITLE="osu lazer installer"
		TITLE="Language Selector"
		MENU="Choose one of the following options:"
	
		OPTIONS=(	1 "English"
				2 "Polski"
				3 "Italiano"
				4 "Deutsch"
				5 "Spanish")
		
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
					SLANGUAGE="english"
					;;
				2)
					SLANGUAGE="polski"
					;;
				3)
					SLANGUAGE="italiano"
					;;
				4)
					SLANGUAGE="german"
					;;
				5)
					SLANGUAGE="spanish"
					;;
				*)
					echo "Error: Language not selected"
					exit 1
					;;
				
		esac
	fi 
	echo "$SLANGUAGE" > langsettings.txt
fi

. ./language/"$SLANGUAGE".sh
export GLOBLANG=$(echo "$SLANGUAGE")


OPTIONS=(1 "$RUN" 
         2 "$COMPILE" 
         3 "$DEPENDS"
         4 "$QUICKFIXES")
         
HEIGHT=15
WIDTH=80
CHOICE_HEIGHT=4


CHOICE=$(dialog --clear \
                --backtitle "$TITLE" \
                --title "$TITLE" \
                --menu "$CHOOSE" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)



case $CHOICE in
        1)
			cd scripts/
			bash run_osulazer.sh
            ;;
        2)
			cd scripts/
			bash build_osulazer.sh
            ;;
        3)
            NewDepInstaller
            ;;
        4)
			cd scripts/
			bash quickfixes.sh
            ;;
		*)
			clear;
			exit 0;
			;;
esac

