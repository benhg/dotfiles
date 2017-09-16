
# System-wide .bee /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, dont do anything
case $- in
    *i*) ;;
      *) return;;
esac

alias ls="ls -G"

# dont put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume its compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac



# some more ls aliases
alias ll='ls -alF'
alias la='ls -a'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you dont need to enable
# this, if its already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some more ls aliases
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CFlh'
alias woo='fortune'
alias lsd="ls -alF | grep /$"

alias diskspace="du -S | sort -n -r |more"
# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"


alias ll="ls -l"
alias lo="ls -o"
alias lh="ls -lh"
alias la="ls -la"

shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

function awkp {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}


function s { 
    if [[ $# == 0 ]]; then
    	sudo $(history -p '!!')
    else
    	sudo "$@"
    fi
}


# dont put duplicate lines in the histor. See bash(1) for more options
HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
HISTCONTROL=ignoreboth

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# cd into the old directory
alias bd='cd "$OLDPWD"'

alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"


alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'


mkcd() {
        if [ $# != 1 ]; then
                echo "Usage: mkcd <dir>"
        else
                mkdir -p $1 && cd $1
        fi
}

# Git related
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gd='git diff'
alias gb='git branch'
alias gl='git log'
alias gsb='git show-branch'
alias gco='git checkout'
alias gg='git grep'
alias gk='gitk --all'
alias gr='git rebase'
alias gri='git rebase --interactive'
alias gcp='git cherry-pick'
alias grm='git rm'

cl() { cd "$@" && la; }

alias dt='date "+%F %T"'

# remind me, its important!
# usage: remindme <time> <text>
# e.g.: remindme 10m omg, the pizza
remindme()
{
    sleep $1 && zenity --info --text "$2" &
}


export PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h:\t\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\]"

calc() {
 echo "$@" | bc -l -q -i 
}

alias grep='grep -In --color=always'
alias emacs="emacs -nw"
alias screen="screen -aARD"
alias make="grc -es make"
function webrage() { sudo sh -c "/etc/rc.d/lighttpd restart; /etc/rc.d/mysqld restart"; }
function naptime() { solid-powermanagement suspend to_ram; }
function comic_on() { xrandr -o right; synclient Rotation=3; }
function comic_off() { xrandr -o normal; synclient Rotation=0; }

alias :hi="history"
alias :x="startx"
alias :rr="sudo su"
alias :rbt="sudo reboot"
alias :shd="sudo shutdown -h now"
alias :z="cd ../"
alias :sv="cd /var/www/" # Go to your local server
alias :ch="sudo chmod 777 -R ./"
alias :q="exit"
alias g:pull="git pull"
alias g:stpl="git stash&&git pull"
alias g:stat="tig"
alias g:branch="git branch"
alias g:check="git checkout"
alias :build="grunt build"
alias :serve="grunt serve"
alias i:serve="ionic serve"
alias i:build="ionic build"
alias i:emulate="ionic emulate"
alias i:run="ionic run"
alias :t="tmux"
alias :work="cd /mnt/Work"
alias v:up="vagrant up"
alias v:halt="vagrant halt"
alias v:ssh="vagrant ssh"

### Functions ###

chs(){
  sudo chmod 777 $1 $2
}

install(){
  brew install $1
}

# mkmv - creates a new directory and moves the file into it, in 1 step
# Usage: mkmv <file> <directory>
mkmv() {	
  mkdir "$2"
  mv "$1" "$2"
}


if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi


bu () {
  cp $1 ${1}-`date +%Y%m%d%H%M`.backup;
}

mktar(){ 
tar cvf  "${1%%/}.tar"     "${1%%/}/"; 
}
mktgz() {
 tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; 
}
mktbz() {
 tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; 
}
weather(){
	curl wttr.in/"${1}"
}
alias lt="ls -thor"
alias lha="ls -lha"
alias portal="ssh ubuntu@datasearch.globuscs.info"

   extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

#   ---------------------------
#   4. SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6. NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
php /etc/dynmotd -f | bash
fortune | cowsay
export bastion='benglick@bastion.turingcompute.net'
export siteservice='ubuntu@34.203.217.232'
alias subl="/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text"
alias gran="git remote add name"
alias gi="git init"
alias gpul="git pull name master"
alias gpus="git push name master"
export slackbot="ubuntu@ec2-34-211-26-13.us-west-2.compute.amazonaws.com"
alias mountslack="sshfs $slackbot:/var/www/slackFlask ~/slackserver -ocache=no -onolocalcaches -ovolname=slack"
alias swift2="/etc/swift/swift-0.96.2/bin/swift"
alias kk="echo 'k.'"
alias mount="sshfs bastion:/home/benglick ~/server -ocache=no -onolocalcaches -ovolname=bastion"
alias mountswift="sshfs siteservice:/var/www/siteservice ~/swiftserver -ocache=no -onolocalcaches -ovolname=siteservice"
alias clean="autopep8 --in-place --aggressive"
export MANPATH=/opt/local/share/man:
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
export PATH=/FPT/:/Users/ben/Desktop/ci17/swift_tutorial/app:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/tcl-tk/bin:/opt/metasploit-framework/bin:/Library/TeX/texbin:/Applications/Wireshark.app/Contents/MacOS:/Applications/pentesting/john:/Applications/pentesting/hashcat:/usr/local/sbin
