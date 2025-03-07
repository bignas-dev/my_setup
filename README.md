# My Setup

Steps to achieve my working environment.

### Ubuntu Installation
https://ubuntu.com/download/desktop

- Dark theme
- Add all software sources
- Find fastest server

```bash
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
```

### Librewolf
```bash
sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update
sudo apt install librewolf -y
```

- Save cookies
- Remove search suggestions

Add plugins:
- uBlock Origin
- Dark Reader
- Sponsorblock

### Gnome Terminal
```bash
sudo apt install gnome-terminal
```

- Enable Dark Mode
- Select "Run command as login shell"
- Select "Run a custom command instead of my shell" and write `zsh`

### Zsh
```bash
sudo apt install zsh zoxide
```

- Paste [zsh](zsh/.zshrc) into `~/.zshrc`
- Run `chsh -s $(which zsh)`

### Neovim
```bash
sudo apt install neovim python3-venv nodejs npm python3-pip
```
- Paste [nvim](nvim) into `~/.config/nvim`

### i3
```bash
sudo apt install i3 qt5ct
```
- Paste [i3](i3/i3) into `~/.config/i3`
- Paste [i3status](i3/i3status) into `~/.config/i3status`

```bash
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
export QT_STYLE_OVERRIDE=adwaita-dark
```
## Secondary Tools

```bash
sudo apt install preload neofetch htop git gh qalc mpv flameshot curl tmux gimp ffmpeg feh libreoffice
curl -LsSf https://astral.sh/uv/install.sh | sh
sudo snap install obsidian bitwarden
```
