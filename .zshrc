
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pontz/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pontz/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pontz/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pontz/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add psql to my PATH
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Make mysql default to 8.0
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# Create an alias, make life easy! 
alias gs='git status'
alias gcam='git commit -a -m'
alias gcm='git commit -m'
alias gc='git commit'
alias gl='git log --graph --oneline'
alias ga='git add'
alias gb='git branch'
alias gpom='git push origin main'
alias grmall='git rm $(git ls-files --deleted)'
alias p='python3'


## Shell Settings
alias show='cat ~/.zshrc'
alias edit-shell='vim ~/.zshrc'
alias ll='ls -l'
alias c='clear'
alias reload-shell='source ~/.zshrc'  # Run Shell Config
alias tcsv="sed -n 's/ | /,/g; s/^| //; s/ |$//; /^[^+]/p' "
alias ttsv="sed -n $'s/ | /\t/g; s/^| //; s/ |$//; /^[^+]/p' "

## Create and Activate Python Virtual Env.
alias cve='python3 -m venv myenv'
alias ave='source myenv/bin/activate'
export PATH="$HOME/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pontz/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pontz/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pontz/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pontz/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="$HOME/.local/bin:$PATH"

## Machine-specific config (not committed to git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

## General utilities

# Move a file from ~/Downloads to a destination (relative or absolute).
# Destination can be a directory (keeps original name) or include a filename (renames).
# Usage: dl <filename> [destination]
# Examples:
#   dl roster.csv                                             # → current dir, same name
#   dl roster.csv 6crickets/scripts/fresno-rosters            # → that dir, same name
#   dl roster.csv 6crickets/scripts/fresno-rosters/input.csv  # → that dir, renamed
dl() {
  local file="${1:-}"
  local dest="${2:-.}"

  [[ -z "$file" ]] && read "file?Filename in Downloads: "

  mv ~/Downloads/"$file" "$dest"
}
_dl() { compadd ~/Downloads/*(N:t) }
compdef _dl dl

## 6cricket scripts
alias new-programs-export='bash /Users/pontz/Projects/6crickets/scripts/new-programs-sessions/export.sh'

# Computes unique present student counts per site by weekday date for a given month.
# Usage: site-daily-attendance [YYYY-MM] [district]
site-daily-attendance() {
  local input="/Users/pontz/Projects/6crickets/scripts/unique-att-month-sites/input.csv"
  local month="${1:-}"
  local district="${2:-}"
  local out="/Users/pontz/Projects/6crickets/scripts/unique-att-month-sites/outputs"

  [[ -z "$month" ]]    && read "month?Month (YYYY-MM): "
  [[ -z "$district" ]] && read "district?District name: "

  python3 /Users/pontz/Projects/6crickets/scripts/unique-att-month-sites/site_daily_attendance.py \
    --input "$input" \
    --month "$month" \
    --district "$district" \
    --out "$out"
}

# Transforms a Fresno roster CSV into per-school XLSX workbooks for a given month.
# Usage: fresno-rosters [month_number] [year]
fresno-rosters() {
  local month="${1:-}"
  local year="${2:-}"

  [[ -z "$month" ]] && read "month?Month (1-12): "
  [[ -z "$year" ]]  && read "year?Year (YYYY): "

  local month_name
  month_name=$(date -j -f "%m" "$(printf '%02d' "$month")" "+%B" 2>/dev/null || date -d "$(printf '%04d-%02d-01' "$year" "$month")" "+%B")

  local base="/Users/pontz/Projects/6crickets/scripts/fresno-rosters"
  local input="$base/input.csv"
  local outdir="$base/FresnoRosters - $month_name $year"

  source ~/roster-env/bin/activate
  python3 "$base/transform_roster.py" \
    --input "$input" \
    --outdir "$outdir" \
    --month "$month" \
    --year "$year"
  deactivate
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
