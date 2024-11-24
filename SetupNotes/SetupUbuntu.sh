#!/bin/bash

# TODO: add neovim setup, add something to make ls better, add something to make autocomplete/history better

# Command to manually use in a clean install to get this script ready to run
# cd && mkdir git && cd git && git clone https://github.com/gigaflux0/DevNotes.git && cd DevNotes/SetupNotes/ && bash ./SetupUbuntu.sh


# Manual step to set background image and style
# Terminal > Settings > Ubuntu > Color scheme = Tango Dark ... Background image > Select an image, 20% opacity

configure_git_for_this_repo () {
  # Config git to use the credential manager in windows (git must be installed in windows via winget for this to work)
  git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
  # Config git just on this repo (can skip this step if we never want to push to remote)
  git config user.email "georgemason321@hotmail.com" && git config user.name "georg"
}

install_fastfetch () {
  echo "YOYO Installing fastfetch"
  sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
  sudo apt update
  sudo apt install fastfetch
  echo "YOYO Finished installing fastfetch"
  echo "YOYO Adding fastfetch configuration to bashrc"
  echo '' >> ~/.bashrc 
  echo '# Run fastfetch on startup' >> ~/.bashrc 
  echo 'fastfetch' >> ~/.bashrc 
  echo "YOYO Finished adding fastfetch configuration to bashrc"
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

install_rider () {
  sudo snap install rider --classic
}

install_firefox () {
  sudo apt install firefox
}

install_docker () {
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  
  # add your local user in the docker group, so no sudo is needed for running docker
  sudo usermod -aG docker $(whoami)

  # reload group settings
  newgrp docker
}

install_kind () {
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.25.0/kind-linux-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind
}

install_kubectl_kubectx_kubens () {
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
  sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
}

install_k9s () {
  sudo snap install k9s
  sudo ln -s /snap/k9s/current/bin/k9s /snap/bin/
}

echo "Hello World!"

echo "YOYO running sudo apt-get update"
sudo apt-get update
echo "YOYO finished running sudo apt-get update"

configure_git_for_this_repo
install_fastfetch
install_and_configure_oh_my_posh
install_rider
install_firefox
install_docker
install_kind
install_kubectl_kubectx_kubens
install_k9s

echo "Goodbye World!"


# Sanity checks
# docker info
# kind version
# kubectl version
# sudo docker run hello-world
# kind create cluster --name bleh
# kind delete cluster --name bleh