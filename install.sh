#!/bin/bash

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    case "$XDG_CURRENT_DESKTOP" in
        "GNOME"|"ubuntu:GNOME"|"Unity")
            echo "Wayland Gnome session detected."
            echo "gnome-randr is required for Gnome Wayland to work."
            read -p "Do you want to download and install gnome-randr? (Y/n): " response
            response=${response,,}
            if [[ "$response" == "y" || "$response" == "" ]]; then
                GNOME_RANDR_URL="https://raw.githubusercontent.com/Odizinne/gnome-randr-py/main/gnome-randr"
                INSTALL_PATH="/usr/local/bin/gnome-randr"
                echo "Downloading gnome-randr..."
                
                TEMP_PATH="/tmp/gnome-randr"
                curl -o "$TEMP_PATH" "$GNOME_RANDR_URL"
                
                if [ $? -eq 0 ]; then
                    echo "Download complete. Installing gnome-randr..."
                    sudo mv "$TEMP_PATH" "$INSTALL_PATH"
                    sudo chmod +x "$INSTALL_PATH"
                    echo "gnome-randr has been installed to $INSTALL_PATH"
                else
                    echo "Failed to download gnome-randr. Please check your internet connection or the URL and try again."
                    exit 1
                fi
            else
                echo "gnome-randr installation skipped. You may not be able to start BigPictureTV on Wayland Gnome without it."
            fi
            ;;
    esac
fi

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
echo ""
echo "Setup complete. BigPictureTV should now be available in your applications menu."
