# Youtube DL Helper
function pull()  {
  local CURRENT_DIR=$(pwd)

  local REQUEST_URL=$1

  local OUTPUT_DIR="${OUTPUT_DIR:-"storage/external-1/Movies"}"
  local LIST_FILE=${LIST_FILE:-"download-list.txt"}

  local WORKING_DIR="$HOME/$OUTPUT_DIR"

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
