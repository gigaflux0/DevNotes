#!/bin/bash

# Command to manually use in a clean install to get this script ready to run
# cd && mkdir git && cd git && git clone https://github.com/gigaflux0/DevNotes.git && cd DevNotes/SetupNotes/ && bash ./SetupUbuntu.sh

install_rider () {
  sudo snap install rider --classic
}

install_and_configure_oh_my_posh () {
  echo "YOYO Installing unzip"
  sudo apt install unzip
  echo "YOYO Finished installing unzip"

  echo "YOYO Installing oh-my-posh"
  curl -s https://ohmyposh.dev/install.sh | bash -s
  echo "YOYO Finished installing oh-my-posh"

  echo "YOYO Adding oh-my-posh configuration to bashrc"
  echo '' >> ~/.bashrc 
  echo '# Add local bin to path so oh-my-posh command will work' >> ~/.bashrc 
  echo 'export PATH=$PATH:/home/gigaflux0/.local/bin' >> ~/.bashrc 
  echo '' >> ~/.bashrc 
  echo '# Configure OhMyPosh' >> ~/.bashrc 
  echo 'eval "$(oh-my-posh --init --shell bash --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/illusi0n.omp.json')"' >> ~/.bashrc
  echo "YOYO Finished adding oh-my-posh configuration to bashrc"
  
  exec bash
}

echo "Hello World!"
# install_rider

echo "YOYO running sudo apt-get update"
sudo apt-get update
echo "YOYO finished running sudo apt-get update"

install_and_configure_oh_my_posh

echo "Goodbye World!"
