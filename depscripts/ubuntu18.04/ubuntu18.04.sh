#!/bin/bash

# Dependency Install Script for ubuntu 18.04
#
# It will install the dependencies AND Check if they are correctly installed.
# 
# Those scripts should contain functions that deal with the installation process of every dependency part seperatly.
#
# This script should be run as root.
#

function Dotnet
{
	read -r -p "This Script is activating the Universe Repo. Are you sure? [y/N] " response
	response=${response,,}    # tolower
	if [[ "$response" =~ ^(yes|y)$ ]] ; then		
		wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
		dpkg -i packages-microsoft-prod.deb
		echo "Dotnet Repo added"
	
		add-apt-repository universe
		apt install apt-transport-https -y
		apt update
		apt install dotnet-sdk-2.2 -y
	
		if ! [ -x "$(command -v dotnet)" ]; then
			echo 'Error: dotnet core sdk could not be installed' >&2
			echo 'If you are running the correct Distro Version for this script, make a issue on github' >&2
		exit 1
	fi

fi
}

function BassDeps
{
	echo "Install libbass shared object"
	if [ ! -f /usr/lib/libbass.so ]; then
		echo "File is not placed, installing..."
		cp bin/libbass.so /usr/lib/
	fi
	
	echo "Install libbass_fx shared object"
	if [ ! -f /usr/lib/libbass_fx.so ]; then
		echo "File is not placed, installing..."
		cp bin/libbass_fx.so /usr/lib/
	fi
}

function OtherDeps
{
	apt install libgbm-dev libglfw3-dev libgles2-mesa-dev libsdl2-dev -y
	ln -s /usr/lib/libgbm.so.1 /usr/lib/libgbm.so
}

Dotnet
BassDeps
OtherDeps
