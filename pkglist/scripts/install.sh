#!/bin/bash

# Define info func
Parent_thread() {
	echo -e "\033[1;32m==>\033[0m \033[1;37m$1...\033[0m"
}

Child_thread() {
	echo -e "\033[1;34m ->\033[0m \033[1;37m$1...\033[0m"
}

Warning() {
	echo -e "\033[1;33m::\033[0m \033[1;37m$1\033[0m"
}

Error() {
	echo -e "\033[1;31merror:\033[0m \033[1;37m$1.\033[0m"
}

# Cd to the parent directory of install script
cd "$(dirname "$0")" || exit 1

# Install `paru` first to avoid some problems
Parent_thread "Install AUR helper"
sudo pacman -S --needed paru

# Check pkglist file
pkglist_newest="../pkglist_newest.txt"
pkglist_all_newest="../pkglist_all_newest.txt"
if [[ ! -f "$pkglist_all_newest" && ! -f "$pkglist_newest" ]]; then
	Error "pkglist file does not exit in the upper directory"
	exit 1
fi

# Install packages
Parent_thread "Install packages"

if ! grep -Fxvqf <(paru -Qq) "$pkglist_newest"; then
	:
elif ! paru -S --needed $(grep -Fxvf <(paru -Qq) "$pkglist_newest"); then
	Error "failed , please try again"
	exit 1
fi

# Install code extensions
Parent_thread "Install code extensions"
# Read extension IDs from a.txt and install them
code_extensions="../code_extensions.txt"
while IFS= read -r extension_id; do
	code --install-extension "$extension_id"
done <$code_extensions

# System settings
Parent_thread "System settings"

# Change default shell
Child_thread "Change shell to zsh"
if ! echo "$SHELL" | grep -q "/usr/bin/zsh"; then
	chsh -s /usr/bin/zsh
fi

# restore files
Parent_thread "Restore files and settings"

# Check the owner
bool=

Child_thread "Check the user"
while true; do
	Warning "Are you the owner of the repository and already setting the ssh? [Y/n]"
	read -r input

	case $input in
	[yY][eE][sS] | [yY])
		bool=true
		break
		;;
	[nN][oO] | [nN])
		bool=false
		break
		;;

	*)
		Error "invalid input"
		;;
	esac
done

# Clone dotfiles
Child_thread "Clone dotfile"
Warning "Default cloning to ~/.dotfile. Feel free to exit and change it. Continue? [Y/n]"
while true; do
	read -r input

	case $input in
	[yY][eE][sS] | [yY])
		break
		;;
	[nN][oO] | [nN])
		exit 0
		;;

	*)
		Error "invalid input"
		;;
	esac
done

DOT_DIR="$HOME/.dotfile"

if [ -d "$DOT_DIR" ]; then
	mv "$DOT_DIR" "$DOT_DIR".bak
	Warning "Has made a backup of .dotfile into .dotfile.bak"
fi

# Confirm install
if ($bool && git clone git@github.com:auryouth/wsl-dot.git "$DOT_DIR") || (! $bool && git clone https://github.com/auryouth/wsl-dot.git "$DOT_DIR"); then
	while true; do
		Warning "Are you sure to install? [Y/n]"
		read -r input

		case $input in
		[yY][eE][sS] | [yY])
			cd "$DOT_DIR" || exit 1
			./install
			break
			;;
		[nN][oO] | [nN])
			exit 1
			;;

		*)
			Error "invalid input"
			;;
		esac
	done
else
	Error "failed, please make sure you have cloned the dotfile"
	exit 1
fi
