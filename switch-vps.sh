#!/bin/bash
# This script is depending on the python script edit_json.py
# 获取所需变量
# 更改env
while getopts ":a:i:d:" opt; do
	case ${opt} in
    a)
        # 更改 .profile配置
        sed -i_bak '/REMOTE_SSH/d' $HOME/.profile
        echo "export REMOTE_SSH=$OPTARG" >> $HOME/.profile
        # 修改当前enviroment
        export REMOTE_SSH=$OPTARG
        ;;
    i)
        IP=$OPTARG ;;
    d)
        DOMAIN=$OPTARG ;;
	:) 
        echo "Invalid option: $OPTARG needs an argument"
        exit 1
        ;;
	\?)
		echo "Invalid option: $OPTARG" #There is no match flags
        exit 1
		;;
	esac
done

# 更改client configure ip
python3 edit_json.py $IP $DOMAIN
