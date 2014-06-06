# Mac OSX

export PATH=/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
export CLICOLOR=1
alias ls='CLICOLOR_FORCE=1 ls -G'
alias more='more -R'
alias l="ls -alsG"
alias u="cd .."
alias dir="ls -als"
alias lm="l | more"
alias ll="l | less -R"
PS1='\u@\h:\w$ '


# MacPorts Installer addition on 2012-11-14_at_10:30:24: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

