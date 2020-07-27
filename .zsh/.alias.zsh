# git
alias git-s='git status'
alias git-u='git add -u'
alias git-us='git-u; git-s'
alias git-m='git commit -m'
alias git-g='git log --graph'
alias git-d='git diff'
alias git-dh='git diff HEAD'

alias glg='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias ghb='hub browse'

# ls
alias lla='ll -a'

# image
alias heic2jpg='for i in `ls *.heic *.HEIC`; do; sips --setProperty format jpeg $i --out ${i%.*}.jpg; done; rm *.heic'
