#!/bin/sh

print_usage() {
	printf "Usage: syc-config.sh -a remote_server_address"
}

while getopts "cs" opt; do
	case ${opt} in
	c)
		echo ">>>>>>>>>Copy files to the cliend end..."
		if [[ -z "${V2RAY_CLIENT_CONFIG_LOC}" ]]; then
			echo "${V2RAY_CLIENT_CONFIG_LOG} is needed"
		else
			cp ${V2RAY_CLIENT_CONFIG_LOC} /usr/local/etc/v2ray
			echo ">>>>>>>>>Restart client v2ray..."
			brew services restart v2ray
			brew services
		fi
		;;
	s) # Sync for server side
		if [[ -z "${V2RAY_SERVER_CONFIG_LOC}" ]] || [[ -z "${REMOTE_SSH}" ]]; then
			echo "V2RAY_CONFIG_LOC and REMOTE_SSH should be set"
			exit 1
		else
			echo ">>>>>>>>>Rsync file to the remote server end..."
			rsync -Pz ${V2RAY_SERVER_CONFIG_LOC} $REMOTE_SSH:/usr/local/etc/v2ray/config.json
			echo ">>>>>>>>>Restart v2ray for remote server..."
			ssh ${REMOTE_SSH} "sudo service v2ray restart; sudo service v2ray status"
		fi
		;;
	\?)
		print_usage
		echo "Invalid option: $OPTARG" #There is no match flags
		;;
	esac
done
echo ">>>>>>>>>Done!"
