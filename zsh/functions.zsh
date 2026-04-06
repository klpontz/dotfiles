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
