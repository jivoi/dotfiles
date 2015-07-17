#!/bin/bash
export PATH=~/bin/:~/.rvm/bin:/cygdrive/c/Go/bin:/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/games:/usr/lib/java/bin:/usr/lib/java/jre/bin:/usr/lib/qt/bin:/usr/lib/qt4/bin:/usr/share/texmf/bin:/opt/kde/bin:/opt/java/jre/bin:/opt/pt/bin:/opt/pt/lib:/opt/java/jre/bin

shopt -s nocaseglob
shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize
shopt -s histappend

for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
 . /usr/share/bash-completion/bash_completion
fi

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

if [ -f ~/bin/z.sh ]; then
 . ~/bin/z.sh
fi

# SSH Keychain
if [ -x /usr/bin/keychain ]; then
  keychain -q --ignore-missing --nocolor ~/.ssh/id_rsa 2>/dev/null
  . ~/.keychain/$HOSTNAME-sh
fi

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# NVM
export NVM_DIR="/home/ekoz/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
