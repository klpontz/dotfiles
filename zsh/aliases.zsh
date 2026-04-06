# =============================================================================
# Git
# =============================================================================

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gl='git log --graph --oneline --all'
alias gb='git branch'
alias gpom='git push origin main'
alias grmall='git rm $(git ls-files --deleted)'


# =============================================================================
# Shell
# =============================================================================

alias ll='ls -l'
alias c='clear'
alias p='python3'
alias show='cat ~/dotfiles/.zshrc'
alias edit-shell='vim ~/dotfiles/.zshrc'
alias reload-shell='source ~/.zshrc'

# Python virtual env
alias cve='python3 -m venv myenv'
alias ave='source myenv/bin/activate'

# Convert mysql/psql table output to CSV or TSV
alias tcsv="sed -n 's/ | /,/g; s/^| //; s/ |$//; /^[^+]/p' "
alias ttsv="sed -n $'s/ | /\t/g; s/^| //; s/ |$//; /^[^+]/p' "
