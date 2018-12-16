#/bin/bash

function NewDepInstaller
{
	HEIGHT=15
	WIDTH=40
	CHOICE_HEIGHT=4
	BACKTITLE="osu lazer installer"
	TITLE="Depinstaller"
	MENU="Choose one of the following options:"

	OPTIONS=(1 "Ubuntu 18.04"
         2 "Placeholder"
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
			echo ##Placeholder
            ;;
        3)
            echo ##Placeholder
            ;;
        4)
            echo ##Placeholder
            ;;
        *)
			echo "Error: Distribution not selected"
			exit 1
			;;
         
	esac
	
	
}

if ! [ -x "$(command -v dialog)" ]; then
  echo 'Error: dialog not installed, it is required by the tool.' >&2
  exit 1
fi

if [ -e langsettings.txt ]; then
	SLANGUAGE=$(<langsettings.txt)
else



HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="osu lazer installer"
TITLE="Language Selector"
MENU="Choose one of the following options:"

OPTIONS=(1 "English"
         2 "Polski"
         3 "Italiano"
         4 "Deutsch")

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
        *)
			echo "Error: Language not selected"
			exit 1
			;;
         
esac
	
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
			if [ -d "scripts/osu" ]; then
				cd scripts/
				sh run_osulazer.sh
			else
				echo "$NOOSUFOUND"
			fi
            ;;
        2)
			if [ -d "scripts/osu" ]; then
				cd scripts/
				dialog --title "$OLDOSUFOUND" --backtitle "$BUILDNEWASK" --yesno "$SURETODELETE" 7 60
				response=$?
				case $response in
					0) sudo rm -r osu/ && sh build_osulazer.sh;;
					1) echo "$OSUNOTREMOVED";;
					255) echo "$ESCPRESSED";;
				esac
			else
				cd scripts/
				sh build_osulazer.sh
			fi            
            ;;
        3)
            NewDepInstaller
            ;;
        4)
			cd scripts/
			bash quickfixes.sh
            ;;
esac

