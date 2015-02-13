setenv PATH /bin:/sbin:/usr/bin:/usr/sbin:/libexec:/usr/libexec:/usr/local/bin:/usr/local/sbin:/usr/local/apache/bin:/usr/local/apache2/bin:/usr/local/nginx/sbin:/usr/local/nginx/bin:/usr/local/etc/rc.d:/etc/rc.d
#setenv MANPATH /usr/man:/usr/local/man:/usr/local/nginx/man:/usr/local/apache2/man:/usr/local/apache/man

if ( ${uid} == 0 ) set root

setenv LC_CTYPE ru_RU.CP1251
setenv LC_COLLATE ru_RU.CP1251
set history = 500

set nobeep
set color
set autolist
unset histfile

set rgb_restore   = '%{^[[00m%}'
set rgb_black     = '%{^[[00;30m%}'
set rgb_firebrick = '%{^[[00;31m%}'
set rgb_red       = '%{^[[01;31m%}'
set rgb_forest    = '%{^[[00;32m%}'
set rgb_green     = '%{^[[01;32m%}'
set rgb_brown     = '%{^[[00;33m%}'
set rgb_yellow    = '%{^[[01;33m%}'
set rgb_navy      = '%{^[[00;34m%}'
set rgb_blue      = '%{^[[01;34m%}'
set rgb_purple    = '%{^[[00;35m%}'
set rgb_magenta   = '%{^[[01;35m%}'
set rgb_cadet     = '%{^[[00;36m%}'
set rgb_cyan      = '%{^[[01;36m%}'
set rgb_gray      = '%{^[[00;37m%}'
set rgb_white     = '%{^[[01;37m%}'
set rgb_std       = "${rgb_gray}"

if ( ${?root} ) then
    set ch = "#"
    set rgb_usr = "${rgb_red}"
else
    set ch = '$'
    set rgb_usr = "${rgb_green}"
endif

#if ( $TERM == "xterm-color" ) then

        set prompt="${rgb_usr}%n${rgb_std}@${rgb_forest}%M ${rgb_std}%~${rgb_usr}${ch}${rgb_std} "
#        else
#        set prompt='%n@%B%M%b %~]$ '
#endif

if ( "$HOSTTYPE" == "") then
        set os=`uname -s`
        else
        set os=$HOSTTYPE
endif

switch ($os)
        case *[Bb][Ss][Dd]*:
                alias ls ls -aGo
        breaksw
        case *[Ll]inux*:
                alias ls ls --color -a
        breaksw
endsw
alias ls 'ls -lGF'
alias ll 'ls -lG'
alias p 'passwd r_ekozyrev'
alias killme 'kill -9 $$'

if ( -X vim ) then
                setenv EDITOR vim
            alias vi vim
    else
        setenv EDITOR vi
        alias vim vi
endif

if ( -f ~/.ssh/known_hosts ) then
        set hosts = `awk '{printf("%s ",$1)} END {printf("www.ru" )}' ~/.ssh/known_hosts`
        complete ping 'p/1/$hosts/'
        complete ssh 'p/*/$hosts/'
        complete telnet 'p/*/$hosts/'
        complete traceroute 'p/*/$hosts/'
        complete host 'p/*/$hosts/'
        complete dig 'p/*/$hosts/'
endif

complete kill 'c/-/S/' 'p/1/(-)//'
complete chown 'p/1/u/'
complete id 'p/1/u/'
complete su 'p/1/u/'

bindkey -s   ^[[17~  "\16uptime\n" #f6
bindkey -s   ^[[18~  "\16w\n"      #f7
bindkey -s   ^[[19~  "\16clear\n"  #f8

alias hupnginx 'ps ax|grep nginx|grep master|cut -f1 -d' '|xargs kill -HUP'
alias msk `curl -s "http://www.google.com/ig/api?weather=Moscow" | sed 's|.*<temp_c data="\([^"]*\)"/>.*|\1|'`

#set watch = (0 any any)
set filec
limit coredumpsize 0
