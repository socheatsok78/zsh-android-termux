#* >>> Welcome >>>
function andrew() {
  echo -e "     _              _                   "
  echo -e "    / \   _ __   __| |_ __ _____      __"
  echo -e "   / _ \ | '_ \ / _\` | '__/ _ \ \ /\ / /"
  echo -e "  / ___ \| | | | (_| | | |  __/\ V  V / "
  echo -e " /_/   \_\_| |_|\__,_|_|  \___| \_/\_/  "
  echo -e " \n A senior developer is helpful, not all- \n knowing.\n"
}

function welcome() {
  if [ `command -v lolcat` ]; then
    andrew | lolcat;
  else
    andrew;
  fi
}
#* <<< Welcome <<<

alias history="fc -il 1"
alias h="omz_history"
alias ll="la"
alias shred="rm -P"

#! >>> Emojoy >>>
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy";
alias fight="echo '(ง'̀-'́)ง' | pbcopy";
#! <<< Emojoy <<<

#! >>> Youtube DL Helper >>>
function pull()  {
  local CURRENT_DIR=$(pwd)

  local REQUEST_URL=$1

  local OUTPUT_DIR="${OUTPUT_DIR:-"storage/external-1/Movies"}"
  local LIST_FILE=${LIST_FILE:-"download-list.txt"}

  local WORKING_DIR="$HOME/$OUTPUT_DIR"
  
  # Check if url is provided
  if [ -z "$REQUEST_URL" ]; then
    echo "Please provide url to start pulling..."
    exit 127
  fi

  echo "Changing working dir... $OUTPUT_DIR/$LIST_FILE"
  
  if [ ! -d "$WORKING_DIR" ]; then
    mkdir -p "$WORKING_DIR"
  fi

  cd "$WORKING_DIR"

  # Create file if not exist
  if [ ! -f "$file" ]; then
    touch "$LIST_FILE"
  fi

  echo "Starting to download..."

  youtube-dl -c -f best --console-title --no-mtime "$@"

  # Check for existing download
  if grep -qxF "$REQUEST_URL" "$LIST_FILE"; then
  else
    echo "$REQUEST_URL" >> "$LIST_FILE"
  fi

  cd $CURRENT_DIR
  echo "Done!"
}
#! <<< Youtube DL Helper <<<

# Start
welcome;
