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
# Check for existing download
function list_exist() {
  local URL=$1
  local FILE=$2

  grep -qxF "$URL" "$FILE" > /dev/null 2>&1
}

function append_to_list() {
  local URL=$1
  local FILE=$2

  echo "$URL" >> "$FILE"
}

function do_movie_download() {
  echo "Starting to download..."
  youtube-dl -c -f best --console-title --no-mtime "$@"
}

function queue() {
  local CURRENT_DIR=$(pwd)

  local REQUEST_URL=$1

  local OUTPUT_DIR="${OUTPUT_DIR:-"storage/external-1/Movies"}"
  
  local QUEUE_FILE=${QUEUE_FILE:-"download-queue.txt"}
  local LIST_FILE=${LIST_FILE:-"download-list.txt"}

  if ! list_exist "$REQUEST_URL" "$OUTPUT_DIR/$LIST_FILE" && ! list_exist "$REQUEST_URL" "$OUTPUT_DIR/$QUEUE_FILE"
  then
    # Add to queue
    echo "[QUEUED] $REQUEST_URL"
    append_to_list "$REQUEST_URL" "$OUTPUT_DIR/$QUEUE_FILE"
  else
    echo "You've already downloaded/queued this video!"
  fi
}

function batch_pull() {
  local QUEUE_FILE=${QUEUE_FILE:-"download-queue.txt"}
  echo "Starting queue...\n"
  
  while IFS= read -r line
  do
    echo "[PROCESSING] $line"
    pull "$line"
  done < "$QUEUE_FILE"

  echo "\nQueue completed!"
}

function pull()  {
  local CURRENT_DIR=$(pwd)

  local REQUEST_URL=$1

  local OUTPUT_DIR="${OUTPUT_DIR:-"storage/external-1/Movies"}"
  local LIST_FILE=${LIST_FILE:-"download-list.txt"}
  local FAIL_FILE=${FAIL_FILE:-"download-failed.txt"}

  local WORKING_DIR="$HOME/$OUTPUT_DIR"
  
  # Check if url is provided
  if [ -z "$REQUEST_URL" ]; then
    echo "Please provide url to start pulling..."
    return 1
  fi

  echo "Changing working dir... $OUTPUT_DIR"
  
  if [ ! -d "$WORKING_DIR" ]; then
    mkdir -p "$WORKING_DIR"
  fi

  cd "$WORKING_DIR"

  # Create file if not exist
  if [ ! -f "$file" ]; then
    touch "$LIST_FILE"
  fi

  # youtube-dl -c -f best --console-title --no-mtime "$@"
  if ! do_movie_download "$@"; then
    # If download failed
    if ! list_exist "$REQUEST_URL" "$FAIL_FILE"; then
      # Add to failed list
      append_to_list "$REQUEST_URL" "$FAIL_FILE"
    fi
  else
    # If download success
    if ! list_exist "$REQUEST_URL" "$LIST_FILE"; then
      # Add to success list
      append_to_list "$REQUEST_URL" "$LIST_FILE"
    fi
  fi


  cd $CURRENT_DIR
  echo "Done!"
}
#! <<< Youtube DL Helper <<<

function do_android_termux_update() {
  local PLUGIN_DIR="$ZSH/custom/plugins/android-termux"
  local CURRENT_DIR=$(pwd)

  cd "$PLUGIN_DIR"
  if git pull --rebase --stat origin master
  then
    welcome
  else
    echo 'There was an error updating. Try again later?' 
  fi
  cd "$CURRENT_DIR"
}

# Start
welcome;
