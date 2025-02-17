send_completions() {
  echo $'#!/usr/bin/env bash'
  echo $''
  echo $'# This bash completions script was generated by'
  echo $'# completely (https://github.com/dannyben/completely)'
  echo $'# Modifying it manually is not recommended'
  echo $'_cli_completions() {'
  echo $'  local cur=${COMP_WORDS[COMP_CWORD]}'
  echo $''
  echo $'  case "$COMP_LINE" in'
  echo $'    \'cli completions\'*) COMPREPLY=($(compgen -W "--help -h" -- "$cur")) ;;'
  echo $'    \'cli download\'*) COMPREPLY=($(compgen -A file -W "--force --help -f -h" -- "$cur")) ;;'
  echo $'    \'cli upload\'*) COMPREPLY=($(compgen -A directory -A user -W "--help --password --user -h -p -u" -- "$cur")) ;;'
  echo $'    \'cli\'*) COMPREPLY=($(compgen -W "--help --version -h -v completions download upload" -- "$cur")) ;;'
  echo $'  esac'
  echo $'}'
  echo $''
  echo $'complete -F _cli_completions cli'
}