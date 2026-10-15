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


# Claude launchers — open a new window with a named profile and launch Claude.
# Terminal.app uses its saved profiles. Ghostty uses _cc_ghostty below.
cc-career() {
  if [[ $TERM_PROGRAM == ghostty ]]; then
    _cc_ghostty /Users/pontz/career-coach career-coach "claude --model sonnet"
    return
  fi
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/career-coach && claude --model sonnet"
    set current settings of w to settings set "_career-coach"
  end tell'
}

cc-code() {
  if [[ $TERM_PROGRAM == ghostty ]]; then
    _cc_ghostty /Users/pontz/Projects/6crickets code "claude --model opus"
    return
  fi
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/Projects/6crickets && claude --model opus"
    set current settings of w to settings set "_code"
  end tell'
}

cc-sql() {
  if [[ $TERM_PROGRAM == ghostty ]]; then
    _cc_ghostty /Users/pontz/Projects/6crickets/coding/SQL sql "claude --model sonnet"
    return
  fi
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/Projects/6crickets/coding/SQL && claude --model sonnet"
    set current settings of w to settings set "_sql"
  end tell'
}

cc-ux() {
  if [[ $TERM_PROGRAM == ghostty ]]; then
    _cc_ghostty /Users/pontz/Projects/6crickets/ux ux "claude --model sonnet"
    return
  fi
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/Projects/6crickets/ux && claude --model sonnet"
    set current settings of w to settings set "_ux"
  end tell'
}

cc-fit() {
  if [[ $TERM_PROGRAM == ghostty ]]; then
    _cc_ghostty /Users/pontz/fit fit "claude"
    return
  fi
  osascript -e 'tell application "Terminal"
    set w to do script "cd /Users/pontz/fit && claude"
    set current settings of w to settings set "_fit"
  end tell'
}


# Ghostty version of the Claude launchers. Ghostty has no named profiles, so
# the new window gets CC_THEME and the shell applies the colors at startup.
# Usage: _cc_ghostty <dir> <theme> <command>
_cc_ghostty() {
  osascript - "$1" "$2" "$3" <<'APPLESCRIPT'
on run argv
  tell application "Ghostty"
    new window with configuration {initial working directory:(item 1 of argv), environment variables:{"CC_THEME=" & (item 2 of argv)}, initial input:(item 3 of argv) & return}
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

if [[ $TERM_PROGRAM == ghostty && -n ${CC_THEME:-} && -n ${_cc_themes[$CC_THEME]:-} ]]; then
  printf '%s' "${_cc_themes[$CC_THEME]}"
fi
