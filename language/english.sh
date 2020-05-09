#/bin/sh

#language pack for the dialoge menu

#Generic
NOTIMPLEMENTED="Not implemented yet"
INSTALLPACKAGES="Installing "

#start.sh
TITLE="osu!lazer build and run script"
WINDOW="Menu"
RUN="Run osu!lazer"
COMPILE="Clone and Compile osu!lazer"
PKG="Make a Linux Executable(not needed)"
DEPENDS="Install Dependencies"
CHOOSE="Choose one of the following options:"
QUICKFIXES="Quickfixes"
QUICKFIXES2="Quickfixes for common problems"
NOOSUFOUND="No osu!lazer found, run build first"
OLDOSUFOUND="old osu!lazer found"
BUILDNEWASK="Do you want to remove the old osu!lazer to build a new one"
SURETODELETE="Are you sure you want to permanently delete your old osu build ( needs root ) "
OSUNOTREMOVED="osu not deleted"
ESCPRESSED="[ESC] key pressed"

#Quickfixes.sh
NOTHINGHERE="Nothing here right now"
DELFRAMEWORKINI="Remove framework.ini, fixing not starting"
DELFRAMEWORKINI2="Removing framework.ini from ~/.local/share/osu"

#AppImage Support
APPIMG_DOWNLOAD_DIALOG="Download osu!lazer AppImage"
APPIMG_NEWEST_ALREADY_DOWNLOADED="Newest version already downloaded"
APPIMG_GITHUB_API_LIMIT="Github API Rate limit reached, wait a few minutes"
APPIMG_ALREADY_DOWNLOADED="This version is already downloaded"
APPIMG_UPDATE_AVAILABLE="New AppImage available, go to AppImage/Download to update"
APPIMG_CHROOT_1="osu!lazer AppImage has to be set executable"
APPIMG_CHROOT_2="We will execute sudo chmod +x $path2 here, if you do not trust this script, do it yourself"
APPIMG_CHROOT_3="Press enter if ready"
APPIMG_CHROOT_ERROR="Error: AppImage not executable"
