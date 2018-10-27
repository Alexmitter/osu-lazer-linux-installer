#/bin/bash

#rm ~/.local/share/osu/framework.ini

. ./../language/english.sh

OPTIONS=(1 "$DELFRAMEWORKINI" 
         2 "Nothing here right now" 
         3 "Nothing here right now"
         4 "Nothing here right now")
         
HEIGHT=15
WIDTH=80
CHOICE_HEIGHT=4


CHOICE=$(dialog --clear \
                --backtitle "$QUICKFIXES2" \
                --title "$Quickfixes" \
                --menu "$CHOOSE" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                
                

case $CHOICE in
        1)
			echo "Removing framework.ini from ~/.local/share/osu"
			rm ~/.local/share/osu/framework.ini
            ;;
        2)
			echo "Not implemented yet"
            ;;
        3)
            echo "Not implemented yet"
            ;;
        4)
			 echo "Not implemented yet"
            ;;
esac
