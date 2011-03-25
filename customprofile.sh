# /etc/profile.d/cpg.sh
# My own custom profile-stuff

# Color highlighted less w/source-highlight
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Eclipse hack
export GDK_NATIVE_WINDOWS=true

PATH=$PATH:/home/cpg/bin

alias clamscan='freshclam; clamscan / -r --quiet --exclude-dir=^/sys\|^/proc\|^/dev'
alias up='yum update -y'
alias ll='ls -lh --color=auto'
alias cssfiles='find -L . -name "*.css"'
alias inifiles='find -L . -name "*.ini*"'
alias jsfiles='find -L . -name "*.js"'
alias phpfiles='find -L . -name "*.php"'
alias sqlfiles='find -L . -name "*.sql"'
alias tplfiles='find -L . -name "*.tpl"'

