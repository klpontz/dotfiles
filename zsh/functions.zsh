# Move a file from ~/Downloads to a destination (relative or absolute).
# Destination can be a directory (keeps original name) or include a filename (renames).
# Usage: dl <filename> [destination]
# Examples:
#   dl roster.csv                                             # → current dir, same name
#   dl roster.csv 6crickets/coding/scripts/fresno-rosters            # → that dir, same name
#   dl roster.csv 6crickets/coding/scripts/fresno-rosters/input.csv  # → that dir, renamed
dl() {
  local file="${1:-}"
  local dest="${2:-.}"

  [[ -z "$file" ]] && read "file?Filename in Downloads: "

  mv ~/Downloads/"$file" "$dest"
}
_dl() { compadd ~/Downloads/*(N:t) }
compdef _dl dl


# Print a file and copy to the clipboard
copyfile() { cat "$1" | pbcopy; }


# Claude launchers — open a new Terminal window with a named profile and launch Claude
cc-career() {
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/career-coach && claude --model sonnet"
    set current settings of w to settings set "_career-coach"
  end tell'
}

cc-code() {
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/Projects/6crickets && claude --model opus --effort xhigh"
    set current settings of w to settings set "_code"
  end tell'
}

cc-sql() {
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/Projects/6crickets/coding/SQL && claude --model opus --effort xhigh"
    set current settings of w to settings set "_sql"
  end tell'
}

cc-ux() {
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/Projects/6crickets/ux && claude --model opus --effort xhigh"
    set current settings of w to settings set "_ux"
  end tell'
}
