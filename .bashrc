#!/bin/bash

for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

shopt -s nocaseglob
shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize
shopt -s histappend

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

# PowerLine
if [ -f /bin/powerline-daemon ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi
