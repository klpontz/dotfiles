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


# Claude launchers. Pass "g" or "gemini" to start Gemini instead of Claude.
# Ghostty: cd, set the colors, and run in the current tab. Colors reset on exit.
# Terminal.app: open a new window with the saved "_<theme>" profile.
# Usage: cc-code [g|gemini]
cc-career() { _cc_launch /Users/pontz/career-coach career-coach "claude --model sonnet" "$1"; }
cc-code()   { _cc_launch /Users/pontz/Projects/6crickets code "claude --model opus" "$1"; }
cc-sql()    { _cc_launch /Users/pontz/Projects/6crickets/coding/SQL sql "claude --model sonnet" "$1"; }
cc-ux()     { _cc_launch /Users/pontz/Projects/6crickets/ux ux "claude --model sonnet" "$1"; }
cc-fit()    { _cc_launch /Users/pontz/fit fit "claude" "$1"; }

# Usage: _cc_launch <dir> <theme> <claude command> [g|gemini]
_cc_launch() {
  local dir=$1 theme=$2 cmd=$3
  [[ $4 == (g|gemini) ]] && cmd=gemini

  if [[ $TERM_PROGRAM == ghostty ]]; then
    cd "$dir" || return
    printf '%s' "${_cc_themes[$theme]}"
    ${=cmd}
    # Reset text, background, cursor, and palette to the Ghostty defaults.
    printf '\e]110\a\e]111\a\e]112\a\e]104\a'
    return
  fi

  osascript - "$dir" "$cmd" "_$theme" <<'APPLESCRIPT'
on run argv
  tell application "Terminal"
    set w to do script "cd " & quoted form of (item 1 of argv) & " && " & (item 2 of argv)
    set current settings of w to settings set (item 3 of argv)
  end tell
end run
APPLESCRIPT
}

# Colors from the Terminal.app profiles on the Desktop, as escape codes:
# 11 = background, 10 = text, 12 = cursor, 4 = ANSI palette slots.
# All profiles except _fit share the same text, cursor, and palette.
_cc_base=$'\e]10;#f2f2f2\a\e]12;#4d4d4d\a\e]4;0;#666666;2;#56b4e9;3;#f0e442;6;#e69f00;10;#56b4e9;11;#f0e442;14;#e69f00\a'
typeset -gA _cc_themes
_cc_themes[career-coach]=$'\e]11;#122b4d\a'$_cc_base
_cc_themes[code]=$'\e]11;#27092a\a'$_cc_base
_cc_themes[sql]=$'\e]11;#310653\a'$_cc_base
_cc_themes[ux]=$'\e]11;#0d0a21\a'$_cc_base
_cc_themes[fit]=$'\e]11;#7a251e\a\e]10;#d7c9a7\a\e]12;#ffffff\a'
unset _cc_base
