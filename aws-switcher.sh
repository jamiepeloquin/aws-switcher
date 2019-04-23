#!/usr/bin/env bash

#########################################################################################
# Variables
#########################################################################################
AWS_PROFILE='default';
AWS_PROFILE_FILE="./aws-profiler.sh";

#########################################################################################
# Functions
#########################################################################################

##
 # $1 target profile
##
function switchProfile() {
	profile="${1// }";
	export AWS_ACCESS_KEY_ID="$(getProfileProperty aws_access_key_id $profile)";
	export AWS_SECRET_ACCESS_KEY="$(getProfileProperty aws_secret_access_key $profile)";
	export AWS_DEFAULT_REGION="$(getProfileProperty region $profile)";
}

##
 # $1 target AWS Profile Name, default = 'default'
##
function setProfileName() {
	if [[ $# -gt 0 ]] && [[ "${1// }" != "" ]]; then
		AWS_PROFILE="$1";
	fi
}

##
 # $1 AWS Profile Property Name
 # $2 AWS Profile Name
##
function getProfileProperty() {
	property="${1// }"
	profile="${2// }";

	aws configure get "$property" --profile "$profile";
}

#########################################################################################
# Run
#########################################################################################

setProfileName "$1";
switchProfile "$AWS_PROFILE";

echo -e "👉 \033[1m$AWS_PROFILE\033[0m"