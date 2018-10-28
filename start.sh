#/bin/bash



if [ -e langsettings.txt ]; then
	SLANGUAGE=$(<langsettings.txt)
else



HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="Choose one of the following options:"

OPTIONS=(1 "English"
         2 "Polski"
         3 "Italiano")

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
            cd scripts/
			bash dependencies.sh
            ;;
        4)
			cd scripts/
			bash quickfixes.sh
            ;;
esac

