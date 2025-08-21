# My Setup

```bash
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
```

### librewolf
```bash
sudo apt remove firefox --purge -y
sudo apt install extrepo -y
sudo apt update
sudo extrepo enable librewolf
sudo apt install librewolf -y
```
Install plugins:
- Dark Reader
- SponsorBlock
- Return Youtube Dislike
- Vimium

Change settings:
- Don't delete cookies
- Turn on dark mode

```bash
sudo apt install git -y
git clone https://github.com/bignas-dev/my_setup.git
```

### zsh
```bash
sudo apt install zsh zoxide -y
ln -sfn ~/my_setup/zsh/.zshrc ~/.zshrc
chsh -s $(which zsh)
```
Restart PC

### neovim
```bash
sudo apt install neovim python3-venv nodejs npm python3-pip curl -y
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install ruff
ln -sfn ~/my_setup/nvim ~/.config/nvim
```

### i3
```bash
sudo apt install i3 i3status qt5ct flameshot -y
mkdir -p ~/.config/i3
ln -sfn ~/my_setup/i3/i3       ~/.config/i3
ln -sfn ~/my_setup/i3/i3status ~/.config/i3status
```

#### Configure Dark Mode for All GTK Apps
```bash
mkdir -p ~/.config/gtk-3.0
cat > ~/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name=Mint-Y-Dark
gtk-icon-theme-name=Mint-Y-Dark
gtk-application-prefer-dark-theme=1
EOF

cat > ~/.gtkrc-2.0 << EOF
gtk-theme-name="Mint-Y-Dark"
gtk-icon-theme-name="Mint-Y-Dark"
gtk-application-prefer-dark-theme=1
EOF

export QT_QPA_PLATFORMTHEME=qt5ct
echo 'export QT_QPA_PLATFORMTHEME=qt5ct' >> ~/.zshrc
echo 'export GTK_THEME=Mint-Y-Dark' >> ~/.zshrc
```

### More Tools
```bash
sudo apt install preload neofetch htop tealdeer -y
```

