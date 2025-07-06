# Set locale for consistent formatting across applications
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Install antidote if missing (security note: verify repo URL if concerned)
[[ -e ${ZDOTDIR:-~}/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Load antidote plugin manager
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Initialize plugins file if not present
[[ -f ${ZDOTDIR:-~}/.zsh_plugins.txt ]] || {
  cat > ${ZDOTDIR:-~}/.zsh_plugins.txt <<EOL
sindresorhus/pure           # Clean prompt theme
zdharma-continuum/fast-syntax-highlighting kind:defer  # Syntax highlighting
zsh-users/zsh-autosuggestions kind:defer  # Predictive suggestions
EOL
}

# Load plugins statically for faster startup
antidote load

# Symbol configuration
PURE_PROMPT_SYMBOL="❯"        # Main prompt symbol
PURE_PROMPT_VICMD_SYMBOL="❮"  # Vi mode symbol
PURE_CMD_MAX_EXEC_TIME=1      # Show command timing over 1 second
PURE_CLEAR_SCREEN=0           # Keep prompt on screen clear
PURE_NEW_LINE=0               # Keep prompt on same line
PURE_PROMPT_COMMAND_PREFIX=   # Remove execution time prefix

# Color customization using zstyle
zstyle :prompt:pure:path color cyan          # Current directory color
zstyle :prompt:pure:git:branch color yellow  # Git branch color
zstyle :prompt:pure:git:dirty color red      # Dirty state color
zstyle :prompt:pure:prompt:success color green  # Success symbol color
zstyle :prompt:pure:virtualenv color blue    # Python virtualenv color
zstyle :prompt:pure:prompt:continuation color magenta  # Continuation prompt color

# Simplified single-line prompt rendering
prompt_pure_preprompt_render() {
    PROMPT="%(12V.%F{blue}%12v%f .)%F{cyan}%~%f%(1V. %F{yellow}${prompt_pure_state[git_branch]}%f.)%F{green}${PURE_PROMPT_SYMBOL}%f "
}

# Optimized prompt setup hooks
prompt_pure_setup() {
    autoload -Uz add-zsh-hook
    prompt_opts=(cr percent sp subst)
    add-zsh-hook precmd prompt_pure_precmd
    add-zsh-hook preexec prompt_pure_preexec
    prompt_pure_state[prompt]=${PURE_PROMPT_SYMBOL:-❯}
    zle -N prompt_pure_update_vim_prompt_widget
    zle -N prompt_pure_reset_vim_prompt_widget
    PROMPT="%(12V.%F{blue}%12v%f .)%F{cyan}%~%f%(1V. %F{yellow}${prompt_pure_state[git_branch]}%f.)%F{green}${PURE_PROMPT_SYMBOL}%f "
}

# History Configuration
HISTSIZE=10000                 # Session history size
SAVEHIST=10000                 # Persistent history size
HISTFILE=~/.zsh_history        # History file location
setopt inc_append_history      # Save commands immediately
setopt hist_ignore_dups        # Ignore repeated commands
setopt hist_ignore_space       # Don't record commands starting with space
setopt hist_expire_dups_first  # Remove duplicates first when trimming history
setopt share_history           # Share history between sessions

# Initialize completion system with cache
autoload -Uz compinit
compinit -C -d "${ZSH_CACHE:-$HOME}/zcompdump"  # Cache completions for speed

# Input Configuration
bindkey -v  # Use vim key bindings 

# =====================
# Directory Navigation
# ===================
setopt auto_cd     # Change directory without 'cd'
setopt auto_pushd  # Maintain directory stack

# Aliases
alias l='ls -1'    # Single-column list
alias ll='ls -lh'  # Long list format
alias la='ls -lAh'  # Show hidden files
alias ..='cd ..'    # Quick parent navigation

# Initialize Prompt
autoload -U promptinit; promptinit
prompt pure  # Activate customized pure prompt

# Zoxide Integration
# Smart directory jumping (use 'z' instead of 'cd')
eval "$(zoxide init zsh)"

setxkbmap -option caps:escape

export PATH=~/.npm-global/bin:$PATH
