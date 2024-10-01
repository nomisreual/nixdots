# Script for automatically activating
# python virtual environments.

{ pkgs }:
pkgs.writeShellScriptBin "auto_activate_venv" ''

function auto_activate_venv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    # If we're already in a virtual environment, do nothing
    return
  elif [ -d "./.venv" ]; then
    # If .venv directory exists in the current directory, activate it
    source "./.venv/bin/activate"
  fi
}

auto_activate_venv

''
