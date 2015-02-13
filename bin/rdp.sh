#!/bin/sh
username=$1
server_ip=$2

usage(){
        echo "Usage: $0 user server_ip"
        exit 1
}

# invoke  usage
# call usage() function if user and server ip not supplied
[ $# -eq 0 ] && usage


if [ -x /usr/bin/rdesktop ]; then
    /usr/bin/rdesktop -g 1024x768 -P -z -x l -k en-us -r sound:off -u $username $server_ip:3389
else
    echo "no rdesktop, install it first"
fi