# My Setup

### Librewolf
```bash
sudo apt remove firefox --purge -y
sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update
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
sudo apt install git gh tealdeer curl
git clone https://github.com/bignas-dev/my_setup.git
```

### Zsh
```bash
sudo apt install zsh zoxide
rm .zshrc
ln -s ~/my_setup/zsh/.zshrc ~/.zshrc
chsh -s $(which zsh)
```
Restart PC

### Neovim
```bash
sudo apt install neovim python3-venv nodejs npm python3-pip
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
uv tool install ruff
ln -sfn ~/my_setup/nvim ~/.config/nvim
```

### i3
```bash
sudo apt install i3 i3status qt5ct -y
mkdir -p ~/.config/i3 ~/.config/i3status
ln -sfn ~/my_setup/i3/i3 ~/.config/i3/config
ln -sfn ~/my_setup/i3/i3status ~/.config/i3status/config
```

### Secondary Tools

```bash
sudo apt install preload neofetch htop git gh qalc mpv flameshot curl tmux gimp ffmpeg feh libreoffice
```
