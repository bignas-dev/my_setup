# My Setup

Steps to achieve my working environment.

### Ubuntu Installation

Get Ubuntu Deskop from this link:
https://ubuntu.com/download/desktop

- Select proprietary software

### Ubuntu Settings

- Select fastest server
- Select dark mode

```bash
sudo apt update
sudo apt upgrade -y
```

### Firefox Setup

Get `user.js` from this link:
https://github.com/yokoffing/Betterfox/blob/main/user.js

- Install user.js
- Select NextDNS 
- Select DuckDuckGo
- Select dark mode
- Select "Always ask where to save files"

### Dependancies Installation

```bash
sudo apt install gnome-terminal zsh zoxide neovim python3-venv nodejs npm i3
```

### Zsh Setup

- Paste [zsh/.zshrc](.zshrc) into `~/.zshrc`
- Run `chsh -s $(which zsh)`

### Gnome Terminal Setup

- Select Dark Mode
- Select "Run command as login shell"
- Select "Run a custom command instead of my shell" and write `zsh`

### Neovim Setup

- Paste [nvim](nvim) into `~/.config/nvim`

### i3 Setup

- Paste [i3/i3](i3) into `~/.config/i3`
- Paste [i3/i3status](i3status) into `~/.config/i3status`




