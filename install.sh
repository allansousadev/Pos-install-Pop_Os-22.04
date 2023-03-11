#!/usr/bin/env bash
#####################################################################
# Nome: Allan Sousa
# Email: allansousa.dev@gmail.com
#
#
# Nome do programa: Pós install Pop!_OS 22.04
# Versão: 0.3
# Descriição: Pós instalação Pop!_OS em 2023
#
# CHANGELOG:
#####################################################################

echo "Atualização do Sistemas"
echo "================================================================"
sudo apt update -y

sudo apt upgrade -y

echo "Instalando Aplicações"
echo "================================================================"
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
zsh
tilix
git-flow
gnome-tweaks
neovim
neofetch
htop
micro
bashtop
exa
fish
curl
wget
tldr
)

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

echo "Instalação Brave"
echo "================================================================"
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

echo "Instalação Lammp Server"
echo "================================================================"
sudo apt install lamp-server^ -y

echo "Instalação Vscode"
echo "================================================================"
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code -y

echo "Instalação Repósitorio Flatpak"
echo "================================================================"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Instalação Aplicações em Flatpak"
echo "================================================================"
echo "Remmina"
echo "================================================================"
flatpak install flathub org.remmina.Remmina -y
echo "Lutris"
echo "================================================================"
flatpak install flathub net.lutris.Lutris -y
echo "Spotify"
echo "================================================================"
flatpak install flathub com.spotify.Client -y
echo "Microsoft Edge"
echo "================================================================"
flatpak install flathub com.microsoft.Edge -y
echo "VLC"
echo "================================================================"
flatpak install flathub org.videolan.VLC -y
echo "Gimp"
echo "================================================================"
flatpak install flathub org.gimp.GIMP -y
echo "ONLYOFFICE Desktop Editors"
echo "================================================================"
flatpak install flathub org.onlyoffice.desktopeditors -y
echo "Bitwarden"
echo "================================================================"
flatpak install flathub com.bitwarden.desktop -y
echo "Video Downloader"
echo "================================================================"
flatpak install flathub com.github.unrud.VideoDownloader -y
echo "AnyDesk"
echo "================================================================"
flatpak install flathub com.anydesk.Anydesk -y
echo "Kdenlive"
echo "================================================================"
flatpak install flathub org.kde.kdenlive -y
echo "Obsidian"
echo "================================================================"
flatpak install flathub md.obsidian.Obsidian -y
echo "Insomnia"
echo "================================================================"
flatpak install flathub rest.insomnia.Insomnia -y
echo "Postman"
echo "================================================================"
flatpak install flathub com.getpostman.Postman -y
echo "DBeaver Community"
echo "================================================================"
flatpak install flathub io.dbeaver.DBeaverCommunity -y
echo "Flameshot"
echo "================================================================"
flatpak install flathub org.flameshot.Flameshot -y
echo "Google Chrome"
echo "================================================================"
flatpak install flathub com.google.Chrome -y
echo "Hidamari"
echo "================================================================"
flatpak install flathub io.github.jeffshee.Hidamari -y
echo "Obs Studio"
echo "================================================================"
flatpak install flathub com.obsproject.Studio -y
echo "Obsidian"
echo "================================================================"
flatpak install flathub md.obsidian.Obsidian -y
echo "Steam"
echo "================================================================"
flatpak install flathub com.valvesoftware.Steam -y
echo "PCSX2"
echo "================================================================"
flatpak install flathub net.pcsx2.PCSX2 -y

echo "Instalação Docker"
echo "================================================================"
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update -y
sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo docker run hello-world

echo "Pós instalação Docker"
echo "================================================================"
sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

echo "Instalação do Yarn"
echo "================================================================"
npm install --global yarn

echo "Instalação do Laravel"
echo "================================================================"
curl -s https://laravel.build/example-app | bash
cd example-app
 
./vendor/bin/sail up

echo "Instalação Oh-My-Zsh"
echo "================================================================"
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
clear

echo "Definindo zsh como shell padrão"
echo "================================================================"
chsh -s $(which zsh)

# echo "Power-level-10k"
# echo "================================================================"
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# echo "Instalação ASDF"
# echo "================================================================"
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# asdf install nodejs latest
# asdf global nodejs latest

# echo "Instalação syntax-highlighting"
# echo "================================================================"
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# #Descomente a linha abaixo
# echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME} /.zshrc

# echo "Instalação zsh-autosuggestions"
# echo "================================================================"
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# clear

# echo "Instalação fzf"
# echo "================================================================"
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "Finalização, atualização e limpeza"
echo "================================================================"
sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
flatpak upgrade -y
sudo apt autoclean
sudo apt autoremove -y

echo "Fim da instalação"
echo "================================================================"
clear
