#!/bin/bash

SRC_DIR="$(dirname "$(realpath "$0")")"
DEST_DIR="$HOME/.local/bin/BigPictureTV"
DESKTOP_ENTRY_FILE="$HOME/.local/share/applications/bigpicturetv.desktop"

mkdir -p "$DEST_DIR"

cp -r "$SRC_DIR/"* "$DEST_DIR/"

cat > "$DESKTOP_ENTRY_FILE" << EOL
[Desktop Entry]
Name=BigPictureTV
Exec=$DEST_DIR/src/bigpicturetv.py
Icon=$DEST_DIR/src/icons/icon_gamemode.png
Path=$DEST_DIR/src
Terminal=false
Type=Application
EOL

chmod +x "$DESKTOP_ENTRY_FILE"

echo "Setup complete. BigPictureTV should now be available in your applications menu."
