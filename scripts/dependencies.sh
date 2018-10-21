#/bin/bash


. ./../language/english.sh

OPTIONS=(1 "Dotnet 2.1(Placeholder)" 
         2 "Common Debian/Ubuntu Dependencies needed" 
         3 "Installing the Bass Libs from your builded osulazer(Placeholder)"
         4 "Package for fixing multidisplay issues")
         
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
			echo "Not implemented yet"
            ;;
        2)
			echo "Installing libgbm-dev libglfw3-dev libgles2-mesa-dev"
			sudo apt update && apt install libgbm-dev libglfw3-dev libgles2-mesa-dev
			echo "Creating a needed Symlink"
			sudo ln -s /usr/lib/libgbm.so.1 /usr/lib/libgbm.so
            ;;
        3)
            echo "Not implemented yet"
            ;;
        4)
			 echo "Installing libsdl2-dev"
			 sudo apt update && apt install libsdl2-dev
            ;;
esac
