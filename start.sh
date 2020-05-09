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

appimage_run()
{
		let i=0
		W=() 
		while read -r line; do
			let i=$i+1
			W+=($i "$line")
			done < <( ls -1 appimages/ | grep ".AppImage")
		FILE=$(dialog --title "List file of directory /home" --menu "Chose one" 24 80 17 "${W[@]}" 3>&2 2>&1 1>&3)
		clear
		if [ $? -eq 0 ]; then # Exit with OK
			path=$(ls -1 appimages/ | grep ".AppImage" | sed -n "`echo "$FILE p" | sed 's/ //'`")
			path2=$(echo "appimages/$path")
		fi
		if [[ -x "$path2" ]]
		then
			$path2 &
		else
			clear
			echo "$APPIMG_CHROOT_1"
			echo "$APPIMG_CHROOT_2"
			read -p "$APPIMG_CHROOT_3"
			sudo chmod +x $path2
			if [[ -x "$path2" ]]; then
				$path2 &
			else
				clear
				echo "$APPIMG_CHROOT_ERROR"
				exit 0
			fi
		fi
		
		exit 0
}

check_for_appimage_update()
{
	#check if rate limit is exeded
	if [[ $(curl -s https://api.github.com/repos/ppy/osu/releases/latest | grep "API rate limit exceeded")  ]];then
		dialog --msgbox "$APPIMG_GITHUB_API_LIMIT" 10 45
		main_menu
	fi
	build_tag=$(curl -s https://api.github.com/repos/ppy/osu/releases/latest | grep /osu.AppImage | cut -d : -f 2,3 | tr -d \" | grep -v zsync | cut -d '/' -f 8)
	if [[ "osu-$build_tag.AppImage" != $(cat appimages/latest.txt) ]]; then
		dialog --msgbox "$APPIMG_UPDATE_AVAILABLE" 10 45
	fi 
}


download_latest_appimage()
{
	#check if rate limit is exeded
	if [[ $(curl -s https://api.github.com/repos/ppy/osu/releases/latest | grep "API rate limit exceeded")  ]];then
		dialog --msgbox "$APPIMG_GITHUB_API_LIMIT" 10 45
		exit 0
	fi
	new_url_link=$(curl -s https://api.github.com/repos/ppy/osu/releases/latest | grep /osu.AppImage | cut -d : -f 2,3 | tr -d \" | grep -v zsync)
	build_tag=$(curl -s https://api.github.com/repos/ppy/osu/releases/latest | grep /osu.AppImage | cut -d : -f 2,3 | tr -d \" | grep -v zsync | cut -d '/' -f 8)
	if [[ $(cat appimages/latest.txt) == "osu-$build_tag.AppImage" ]]; then
		dialog --msgbox "$APPIMG_NEWEST_ALREADY_DOWNLOADED" 10 45
		exit 0
	fi
	if [ ! -d appimages/ ]; then
	mkdir appimages/
	fi
	if [[ -f "appimages/osu-$build_tag.AppImage" ]]; then
		dialog --msgbox "$APPIMG_ALREADY_DOWNLOADED" 10 45
		main_menu
	fi
	wget $new_url_link -O "appimages/osu-$build_tag.AppImage" 2>&1 | stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | dialog --gauge "$APPIMG_DOWNLOAD_DIALOG" 10 100
	if [[ $? == 0 ]]; then
		echo "osu-$build_tag.AppImage" > appimages/latest.txt
	fi
	main_menu
}

main_menu()
{
	
OPTIONS=(1 "AppImage/Download"
	     2 "AppImage/Run"
         3 "Build/$RUN" 
         4 "Build/$COMPILE" 
         5 "$QUICKFIXES")
         
HEIGHT=20
WIDTH=80
CHOICE_HEIGHT=6


CHOICE=$(dialog --clear \
                --backtitle "$TITLE" \
                --title "$TITLE" \
                --menu "$CHOOSE" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)



case $CHOICE in
        1)
			download_latest_appimage
            ;;
        2)
			appimage_run
            ;;
        3)
			cd scripts/
			bash run_osulazer.sh
            ;;
        4)
			cd scripts/
			bash build_osulazer.sh
            ;;
        5)
			cd scripts/
			bash quickfixes.sh
            ;;
		*)
			clear;
			exit 0;
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

. ./language/english.sh #First load English language pack, so variables that are not yet translated will at least be english instead of empty

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

check_for_appimage_update #Check for AppImage Updates on run

main_menu
