#!/usr/bin/bash

# Variables
UPLOADER_HOME=~/.pantheon
PANTHEON_BIN=~/bin/pantheon
PANTHEON_BIN_PATH_EXPORTED="export PATH=$PATH:$HOME/bin"

if ! grep -q "$PANTHEON_BIN_PATH_EXPORTED" "$HOME/.bashrc" ; then
  echo "in if"
  cp ~/.bashrc ~/.bashrc_bak
  echo "$PANTHEON_BIN_PATH_EXPORTED" >> ~/.bashrc
  source ~/.bashrc
fi

# Create UPLOADER_HOME directory if not exists
if [ ! -d "$UPLOADER_HOME" ]; then
  echo "Creating UPLOADER_HOME directory: $UPLOADER_HOME"
  mkdir -p $UPLOADER_HOME
fi

# Download the pantheon-pantheon_uploader script to $UPLOADER_HOME
echo "Downloading the uploader script to $UPLOADER_HOME"
curl -o ${UPLOADER_HOME}/pantheon.py https://raw.githubusercontent.com/redhataccess/pantheon-uploader/master/pantheon_uploader/pantheon.py
curl -o ${UPLOADER_HOME}/requirements.txt https://raw.githubusercontent.com/redhataccess/pantheon-uploader/master/requirements.txt

pip3 install --user -r ${UPLOADER_HOME}/requirements.txt

# Ensure file is executable
echo "Ensure uploader script is executable"
chmod +x ${UPLOADER_HOME}/pantheon.py

#Creating ~/bin directory if not exists
if [ ! -d ~/bin ]; then
  echo "Creating ~/bin directory"
  mkdir -p ~/bin
fi

# Create a symlink to ~/bin/pantheon if not exists
if [ ! -h "$PANTHEON_BIN" ]; then
  echo "Creating a symlink to $PANTHEON_BIN"
  ln -s ${UPLOADER_HOME}/pantheon.py $PANTHEON_BIN
fi

# Show full path for pantheon command
echo
echo "UPLOADER_HOME: $UPLOADER_HOME"
echo "Pantheon command path: "
which pantheon

if [[ $(which pantheon) = $PANTHEON_BIN ]]; then
  echo "Set up completed!"
fi
echo