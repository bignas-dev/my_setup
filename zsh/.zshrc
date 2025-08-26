# Environment Setup
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Source local environment if it exists
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# =====================
# Plugin Management
# =====================
# Install antidote if missing
if [[ ! -e ${ZDOTDIR:-~}/.antidote ]]; then
    echo "Installing antidote plugin manager..."
    git clone --quiet https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote || {
        echo "Failed to install antidote"
        return 1
    }
fi

# Load antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Initialize plugins file if not present
[[ -f ${ZDOTDIR:-~}/.zsh_plugins.txt ]] || {
    cat > ${ZDOTDIR:-~}/.zsh_plugins.txt <<'EOL'
sindresorhus/pure           # Clean prompt theme
zdharma-continuum/fast-syntax-highlighting kind:defer
zsh-users/zsh-autosuggestions kind:defer
EOL
}

# Load plugins
antidote load

# =====================
# History Configuration
# =====================
HISTSIZE=50000                 # Increased session history
SAVEHIST=50000                 # Increased persistent history
HISTFILE=~/.zsh_history
setopt inc_append_history      # Save commands immediately
setopt hist_ignore_dups        # Ignore repeated commands
setopt hist_ignore_space       # Don't record commands starting with space
setopt hist_expire_dups_first  # Remove duplicates first when trimming
setopt share_history           # Share history between sessions
setopt hist_verify             # Verify history expansions

# =====================
# Shell Options
# =====================
setopt auto_cd                 # Change directory without 'cd'
setopt auto_pushd              # Maintain directory stack
setopt pushd_ignore_dups       # Ignore duplicate directories
setopt pushd_silent            # Don't print directory stack
setopt glob_dots               # Include dotfiles in glob patterns
setopt no_beep                 # Disable beeping
setopt correct                 # Command correction

# =====================
# Completion System
# =====================
# Create cache directory if it doesn't exist
ZSH_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$ZSH_CACHE" ]] || mkdir -p "$ZSH_CACHE"

# Initialize completion with caching
autoload -Uz compinit
compinit -C -d "$ZSH_CACHE/zcompdump"

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive matching

# =====================
# Key Bindings
# =====================
bindkey -v  # Vi mode

# Better vi mode transitions
export KEYTIMEOUT=1

# Fix autosuggestion keys for vi mode
bindkey '^F' autosuggest-accept              # Accept full suggestion
bindkey '^E' forward-word                    # Move forward one word (accepts that word)

# =====================
# Pure Prompt Configuration
# =====================
# Configure Pure theme BEFORE initializing
PURE_PROMPT_SYMBOL="❯"
PURE_PROMPT_VICMD_SYMBOL="❮"
PURE_CMD_MAX_EXEC_TIME=2
PURE_CLEAR_SCREEN=0

# Pure color customization
zstyle ':prompt:pure:path' color cyan
zstyle ':prompt:pure:git:branch' color yellow
zstyle ':prompt:pure:git:dirty' color red
zstyle ':prompt:pure:prompt:success' color green
zstyle ':prompt:pure:virtualenv' color blue

# Initialize prompt system and activate Pure
autoload -U promptinit
promptinit
prompt pure

# Override Pure to use single-line prompt
prompt_pure_preprompt_render() {
    # Build the single-line prompt
    local prompt_parts=""

    # Add virtualenv if present
    if [[ -n ${prompt_pure_state[venv]} ]]; then
        prompt_parts+="%F{blue}${prompt_pure_state[venv]}%f "
    fi

    # Add current directory
    prompt_parts+="%F{cyan}%~%f"

    # Add git info if present
    if [[ -n ${prompt_pure_state[git_branch]} ]]; then
        prompt_parts+=" %F{yellow}${prompt_pure_state[git_branch]}%f"
        if [[ -n ${prompt_pure_state[git_dirty]} ]]; then
            prompt_parts+="%F{red}${prompt_pure_state[git_dirty]}%f"
        fi
    fi

    # Add execution time if present
    if [[ -n ${prompt_pure_state[exec_time]} ]]; then
        prompt_parts+=" %F{magenta}${prompt_pure_state[exec_time]}%f"
    fi

    # Set the final prompt with symbol
    PROMPT="${prompt_parts}%F{green}${PURE_PROMPT_SYMBOL}%f "
}

# =====================
# Directory Navigation
# =====================
# Aliases for common operations
alias l='ls -1'
alias ll='ls -lh'
alias la='ls -lAh'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias vi="nvim"

# Directory stack aliases
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# =====================
# Optional Tool Integration
# =====================
# Zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# Keyboard mapping (with error handling)
if command -v setxkbmap >/dev/null 2>&1; then
    setxkbmap -option caps:escape 2>/dev/null || true
fi

# =====================
# Performance Optimizations
# =====================
# Disable automatic title setting for faster prompt
DISABLE_AUTO_TITLE="true"

# Speed up completion for git
__git_files () { 
    _wanted files expl 'local files' _files     
}

# =====================
# Additional Useful Settings
# =====================
# Better word boundaries (useful for vi mode)
autoload -U select-word-style
select-word-style bash

# Enable better globbing
setopt extended_glob

# Smart URLs - automatically escape special characters
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Mint-Y-Dark
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Mint-Y-Dark
