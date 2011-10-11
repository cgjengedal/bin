# /etc/profile.d/cpg.sh

# source-highlight
[ -x /usr/bin/src-hilite-lesspipe.sh ] && export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Eclipse hack
export GDK_NATIVE_WINDOWS=true

PATH=$PATH:/home/cpg/bin

alias up='yum update -y'
alias ll='ls -lh --color=auto'

# Locating files
alias cssfiles='find -L . -name "*.css"'
alias inifiles='find -L . -name "*.ini*"'
alias jsfiles='find -L . -name "*.js"'
alias phpfiles='find -L . -name "*.php"'
alias sqlfiles='find -L . -name "*.sql"'
alias tplfiles='find -L . -name "*.tpl"'
alias tsfiles='find -L . -name "*.ts"'
alias xmlfiles='find -L . -name "*.xml"'

# Searching inside PHP files
alias noversion='find -L . -name "*.php" ! -exec grep -q "@version" {} \; -print'
alias nocopyright='find -L . -name "*.php" ! -exec grep -q "@copyright" {} \; -print'
alias nolicense='find -L . -name "*.php" ! -exec grep -q "@license" {} \; -print'
alias phpclassnames='phpfiles | xargs grep "^class " | awk "{print \$2}" | sort'
alias sqlops='phpfiles | xargs egrep "mysql_|mysqli_|pg_|oci_"'

# Remove CLI formatting
alias noformatting='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

