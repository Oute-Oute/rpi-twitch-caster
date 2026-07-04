#!/bin/bash

set -e

REPO_URL="https://github.com/Oute-Oute/rpi-twitch-caster.git"
TARGET_DIR="~/client"

echo "Updating package list..."
apt update

echo "Installing git..."
apt install -y git python3 python3-pip libqt5gui5 libqt5webengine5 python3-pyqt5 python3-pyqt5.qtwebengine vlc xinit

if [ ! -d "$TARGET_DIR" ]; then
    echo "Directory does not exist. Cloning repository..."
    git clone "$REPO_URL" "$TARGET_DIR"
else
    echo "Directory exists."

    if [ -d "$TARGET_DIR/.git" ]; then
        echo "Pulling latest changes..."
        git -C "$TARGET_DIR" pull
    else
        echo "Error: $TARGET_DIR exists but is not a git repository."
        exit 1
    fi
fi

echo "Installing dependencies..."

cd "$TARGET_DIR"

echo "Starting app..."
chmod +x main.py
exec xinit /bin/sh -c "sudo -u raspberry ./main.py --fake-fullscreen"