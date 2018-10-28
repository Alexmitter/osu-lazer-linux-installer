#/bin/bash

#rm ~/.local/share/osu/framework.ini

. ./../language/"$GLOBLANG".sh

OPTIONS=(1 "$DELFRAMEWORKINI" 
         2 "$NOTHINGHERE" 
         3 "$NOTHINGHERE" 
         4 "$NOTHINGHERE" )
         
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
			echo "$DELFRAMEWORKINI2"
			rm ~/.local/share/osu/framework.ini
            ;;
        2)
			echo "$NOTIMPLEMENTED"
            ;;
        3)
            echo "$NOTIMPLEMENTED"
            ;;
        4)
			 echo "$NOTIMPLEMENTED"
            ;;
esac
