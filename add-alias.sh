#!/usr/bin/env bash

#########################################################################################
# Variables
#########################################################################################
CURDIR=$(/bin/pwd);
RUN_SCRIPT_NAME="$CURDIR/aws-switcher.sh";
PROFILE_DOT_FILE="$HOME/.bash_profile";

#########################################################################################
# Functions
#########################################################################################

function promptProfileDotFile() {
	IFS= read -r -p "Add the 'alias' to '$PROFILE_DOT_FILE'? [Y/n]: " isProfileFile;
	isProfileFile="${isProfileFile// }";

	case $isProfileFile in
		"n" | "N") setNewDotFile;;
		*) ;;
	esac
}

function setNewDotFile() {
	IFS= read -r -p "Enter the file path for the 'alias' (e.g. $HOME/.bashrc, $HOME/.profile): " newFilePath;
	newFilePath="${newFilePath// }";
	if [[ ! -f "$newFilePath" ]]; then
		echo "'$newFilePath' is not a file.";
		setNewDotFile;
	else
		PROFILE_DOT_FILE="$newFilePath";
	fi
}

function addAlias() {
	echo -e "\n\n## AWS-SWITCHER" >> "$PROFILE_DOT_FILE";
	echo "alias aws-switcher=\"source $RUN_SCRIPT_NAME\"" >> "$PROFILE_DOT_FILE";
	source "$PROFILE_DOT_FILE";
}

#########################################################################################
# Run
#########################################################################################

promptProfileDotFile && addAlias;

echo -e "To use the 'aws-switcher', run \033[1maws-switcher target-profile-name\033[0m in your terminal window.";
