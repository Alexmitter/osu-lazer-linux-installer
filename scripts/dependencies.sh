#/bin/bash


. ./../language/"$GLOBLANG".sh

OPTIONS=(1 "$DOTNETDL" 
         2 "$DEBDEP" 
         3 "$INSTALLBASSLIB"
         4 "$MULSCREEN")
         
HEIGHT=15
WIDTH=80
CHOICE_HEIGHT=4


CHOICE=$(dialog --clear \
                --backtitle "$DEPENDS" \
                --title "$DEPENDS" \
                --menu "$CHOOSE" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
                
                

case $CHOICE in
        1)
			echo "$NOTIMPLEMENTED"
            ;;
        2)
			echo "$INSTALLPACKAGES libgbm-dev libglfw3-dev libgles2-mesa-dev"
			sudo apt update && apt install libgbm-dev libglfw3-dev libgles2-mesa-dev
			echo "Creating a needed Symlink"
			sudo ln -s /usr/lib/libgbm.so.1 /usr/lib/libgbm.so
            ;;
        3)
            echo "$NOTIMPLEMENTED"
            ;;
        4)
			 echo "§INSTALLPACKAGES libsdl2-dev"
			 sudo apt update && apt install libsdl2-dev
            ;;
esac
