parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[ ^.* ]/d' -e 's/* \(.*\)/(\1$(parse_git_dirty))/'
}

function parse_git_branchs {
    git branch --no-color 2> /dev/null | sed -e '/^[ ^.* ]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\[\033[1;31m\]\u \[\033[1;34m\]\$(/usr/bin/tty | sed -e 's:/dev/::'):\W\[\033[1;31m\]\$(parse_git_branch)\[\033[1;35m\] -> \[\033[0m\]"
