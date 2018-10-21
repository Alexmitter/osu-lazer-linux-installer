#/bin/bash

. ./language/english.sh

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



clear
case $CHOICE in
        1)
			if [ -d "scripts/osu" ]; then
				cd scripts/
				sh run_osulazer.sh
			else
				echo "No osulazer found, run build first"
			fi
            ;;
        2)
			if [ -d "scripts/osu" ]; then
				cd scripts/
				dialog --title "old osulazer found" --backtitle "Do you want to remove the old osulazer to build a new one" --yesno "Are you sure you want to permanently delete your old osu build ( needs root) " 7 60
				response=$?
				case $response in
					0) sudo rm -r osu/ && sh build_osulazer.sh;;
					1) echo "osu not deleted.";;
					255) echo "[ESC] key pressed.";;
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

