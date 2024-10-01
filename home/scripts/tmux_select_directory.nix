# Script for starting and switching tmux sessions.
# Folders to look for are hard-coded via PARENT_DIR

{ pkgs }:
pkgs.writeShellScriptBin "tmux_select_directory" ''
  tmux_select_directory() {
  # Project directory
  local PARENT_DIR="$HOME/Projects"

  # Use fd and fzf to select a directory
  local selected_dir

  # Check if we're inside tmux
  if [ -z "$TMUX" ]; then
    # Not inside tmux, use fzf with fullscreen
    # --exec basename shoots me in the foot
    selected_dir=$(fd -td -d 1 . "$PARENT_DIR" |fzf --height 40%  --layout reverse --border --prompt="Select a directory: ")
  else
    # Inside tmux, use fzf-tmux
    selected_dir=$(fd -td -d 1 . "$PARENT_DIR" | fzf --tmux --reverse --prompt="Select a directory: ")
  fi

  # Check if a directory was selected
  if [ -z "$selected_dir" ]; then
    echo "No directory selected."
    return 1
  fi

  # Generate a unique session name
  local session_name
  session_name=$(basename "$selected_dir")

  # Check if we're inside a tmux session
  if [ -z "$TMUX" ]; then
    # Not inside tmux
    tmux new-session -A -s "$session_name" "cd '$selected_dir'; exec $SHELL"
  else
    # Inside tmux
    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux switch-client -t "$session_name"
    else
      tmux new-session -ds "$session_name" "cd '$selected_dir'; exec $SHELL"
      tmux switch-client -t "$session_name"
    fi
  fi
  }
  tmux_select_directory
''
