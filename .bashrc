#!/bin/bash
export PATH=~/bin/:/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/games:/usr/lib/java/bin:/usr/lib/java/jre/bin:/usr/lib/qt/bin:/usr/lib/qt4/bin:/usr/share/texmf/bin:/opt/kde/bin:/opt/java/jre/bin:/opt/pt/bin:/opt/pt/lib:/opt/java/jre/bin

unset MAILCHECK
export NOVACLIENT_DEBUG=1
export KEYSTONECLIENT_DEBUG=1
export OS_USERNAME=
export OS_PASSWORD=
export OS_TENANT_NAME=
export OS_AUTH_URL=

export NOVA_KEY_DIR=/home/ekoz/
export EC2_ACCESS_KEY=
export EC2_SECRET_KEY=
export EC2_URL=
export EC2_USER_ID=42 # nova does not use user id, but bundling requires it
export EC2_PRIVATE_KEY=${NOVA_KEY_DIR}/pk.pem
export EC2_CERT=${NOVA_KEY_DIR}/cert.pem
export NOVA_CERT=${NOVA_KEY_DIR}/cacert.pem
export EUCALYPTUS_CERT=${NOVA_CERT} # euca-bundle-image seems to require this set

export Automoc4_DIR=/usr/lib/automoc4
export LD_LIBRARY_PATH=/opt/pt/lib/:$LD_LIBRARY_PATH
export SVN_SSH="ssh -l ekoz"
export YR_LOGIN="root" 
export PYTHONSTARTUP=~/.pythonrc

# Bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
 . /usr/share/bash-completion/bash_completion
fi

export HISTSIZE=1000000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"
export PAGER="less"
export EDITOR='vim'

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize
shopt -s histappend

BGREEN='\[\033[1;32m\]'
GREEN='\[\033[0;32m\]'
BRED='\[\033[1;31m\]'
RED='\[\033[0;31m\]'
BBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'
NORMAL='\[\033[00m\]'

# Title
if [[ "$UID" == "0" ]] ; then
        PS1="${BRED}\u@${BGREEN}\h: ${BBLUE}\W ${BRED}# ${NORMAL}"
    else
        PS1='\[\033[1;37m\]┌────[\[\033[1;32m\]\u\[\033[1;37m\]@\[\033[1;36m\]\h: \[\033[1;35m\]\w\[\033[1;37m\]]\n\[\033[1;37m\]└─>\[\033[1;34m\]\$\[\033[0m\] '
fi

#PS1='\[\033[02;36m\]\A\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

# Aliases
alias hgrep='history | grep $1'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias lm='ls -latr'
alias ll='ls -l --color=auto' 
alias la='ls -A --color=auto' 
alias l='ls -CF --color=auto'
alias vi='vim'
alias t='tree -L 1 -C -h'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
alias p="sudo pacman"
alias wget='wget --no-check-certificate'
alias scp='scp -oStrictHostKeyChecking=no'
alias ssh='ssh -oStrictHostKeyChecking=no'

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls -hF --color=auto'
  alias dir='ls --color=auto --format=vertical'
  alias vdir='ls --color=auto --format=long'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# SSH Keychain
if [ -x /usr/bin/keychain ]; then
  keychain -q --ignore-missing --nocolor ~/.ssh/id_rsa 2>/dev/null
  . ~/.keychain/$HOSTNAME-sh
fi

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Toys
start() {
    sudo /etc/init.d/$1 start
}

stop() {
    sudo /etc/init.d/$1 stop
}

restart() {
    sudo /etc/init.d/$1 restart
}

ebrc() {
    vim ~/.bashrc
    bash
}

makepasswords() {
    perl <<EOPERL
        my @a = ("a".."z","A".."Z","0".."9",(split //, q{#@,.<>$%&()*^}));
        for (1..10) {
            print join "", map { \$a[rand @a] } (1..rand(3)+8);
            print qq{\n}
        }
EOPERL
}

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

packed() {
    if [ $1 ] ; then
        case $1 in
            tbz)    tar cjvf $2.tar.bz2 $2      ;;
            tgz)    tar czvf $2.tar.gz  $2      ;;
            tar)    tar cpvf $2.tar  $2       ;;
            bz2)    bzip $2 ;;
            gz)     gzip -c -9 -n $2 > $2.gz ;; 
            zip)    zip -r $2.zip $2   ;;
            7z)     7z a $2.7z $2    ;;
            *)      echo "'$1' cannot be packed via packed()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

nscheck() {
  named-checkzone $1 $2
}

dns() {
  dig +nocmd $1 any +multiline +noall +answer
}

myip() {
  curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'
}

futurama() {
  curl -Is slashdot.org | egrep "^X-(F|B)" | cut -d \- -f 2
}

msk() {
  curl -s "http://www.google.com/ig/api?weather=Moscow" | sed 's|.*<temp_c data="\([^"]*\)"/>.*|\1|'
}

dmsgh() {
  dmesg|perl -ne 'BEGIN{$a= time()- qx!cat /proc/uptime!};s/\[(\d+)\.\d+\]/localtime($1 + $a)/e; print $_;'
}

_ssh_hosts() {
  grep "Host " ~/.ssh/config 2> /dev/null | sed -e "s/Host //g"
  cat ~/.ssh/known_hosts 2> /dev/null | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["
}

# if cat is called on a directory, call ls instead
cat() {
  if [ $# = 1 ] && [ -d $1 ]; then
    ls $1
  else
    `which cat` "$@"
  fi
}

# push ssh key to remote host
push_ssh_cert() {
    local _host
    test -f ~/.ssh/id_rsa.pub || echo "no key, run ssh-keygen -t rsa -b 2048"
    for _host in "$2";
    do
        echo "run at $1@$_host"
        ssh-copy-id -i ~/.ssh/id_rsa.pub $1@$_host
        #scp ~/.bashrc  $1@$_host:~/.bashrc
    done
}

# push dotfiles to remote host
push_dotfiles() {
  local _host
  for _host in "$2"; do
    echo "run at $1@$_host"
    ssh $1@$_host '
      if [ ! $(which git) ]; then
        for installer in apt-get yum port brew; do
          if [ $(which $installer) ]; then break; fi
        done
        sudo $installer install git-core || exit
      fi
      git clone https://github.com/jivoi/dotfiles.git $HOME/.dot
      ln -svf $HOME/.dot/{.bashrc,.cshrc,.gitconfig,.screenrc,.tmux.conf,.tmux.status.conf,.vimrc,.zshrc} $HOME/
      ln -svf $HOME/.dot/ssh_config $HOME/.ssh/config'
  done
}

_ssh_completion ()
{
    cur=${COMP_WORDS[COMP_CWORD]};
    COMPREPLY=($(compgen -W '$(cut -d " " -f1 ~/hosts/hosts_all) --all --schema' -- $cur))
}
complete -F _ssh_completion ssh

_fab_completion() {
    COMPREPLY=( $( \
    COMP_LINE=$COMP_LINE  COMP_POINT=$COMP_POINT \
    COMP_WORDS="${COMP_WORDS[*]}"  COMP_CWORD=$COMP_CWORD \
    OPTPARSE_AUTO_COMPLETE=1 $1 ) )
}
complete -F _fab_completion fab

ipmi_bootpxe() {
        local _host
        _host=$1
        if [ -n "${_host}" ]; then
                ipmitool -I lanplus -U ADMIN -P ADMIN -H ${_host} chassis bootdev pxe
        else
                echo "host not specified"
        fi
}

ipmi_reset() {
        local _host
        _host=$1
        if [ -n "${_host}" ]; then
                ipmitool -I lanplus -U ADMIN -P ADMIN -H ${_host} power reset
        else
                echo "host not specified"
        fi
}

ipmi_power_cycle() {
        local _host
        _host=$1
        if [ -n "${_host}" ]; then
                ipmitool -I lanplus -U ADMIN -P ADMIN -H ${_host} power cycle
        else
                echo "host not specified"
        fi
}
