# Aliases
alias hs='hg status'
compdef _hg hs=hg-status

alias hd='hg diff'
compdef _hg hd=hg-diff
alias hds='hg diff --stat'
compdef _hg hds=hg-diff

alias hc='hg commit -v'
compdef _hg hc=hg-commit

alias hca='hg commit -v -a'
compdef _hg gca=hg-commit

alias hl='hg log'
compdef _hg hl=hg-log
alias hll='hg llog'
compdef _hg hll=hg-log
alias hlll='hg lllog'
compdef _hg hlll=hg-log

# Patch Queue stuff
alias hq='hg qseries'
compdef _hg hq=hg-qseries
alias hqr='hg qrefresh'
compdef _hg hqr=hg-qrefresh
# pop/push
alias hqpo='hg qpop'
compdef _hg hqpo=hg-qpop
alias hqpu='hg qpush'
compdef _hg hqpu=hg-qpush
alias hqg='hg qgoto'
compdef _hg hqg=hg-qgoto
# Show the contents of the qtip
alias hqd='hg diff -c qtip --pager always'
compdef _hg hqd=hg-diff
alias hqds='hg diff --stat -c qtip --pager always'
compdef _hg hqds=hg-diff

