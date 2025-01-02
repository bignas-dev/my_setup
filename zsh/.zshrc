# Basic environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Install antidote if not present
[[ -e ${ZDOTDIR:-~}/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Create plugins file if it doesn't exist
[[ -f ${ZDOTDIR:-~}/.zsh_plugins.txt ]] || {
  cat > ${ZDOTDIR:-~}/.zsh_plugins.txt <<EOL
sindresorhus/pure
zdharma-continuum/fast-syntax-highlighting kind:defer
zsh-users/zsh-autosuggestions kind:defer
EOL
}

# Static loading of plugins
antidote load

# Pure theme customization
PURE_PROMPT_SYMBOL="❯"
PURE_PROMPT_VICMD_SYMBOL="❮"
PURE_CMD_MAX_EXEC_TIME=1
PURE_CLEAR_SCREEN=0
PURE_NEW_LINE=0  # Disable new line
PURE_PROMPT_COMMAND_PREFIX=

# Pure color customization
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:git:branch color yellow
zstyle :prompt:pure:git:dirty color red
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:virtualenv color blue
zstyle :prompt:pure:prompt:continuation color magenta

# Override Pure functions to force single line with no newline
prompt_pure_preprompt_render() {
    # Only show git branch and path
    PROMPT="%(12V.%F{blue}%12v%f .)%F{cyan}%~%f%(1V. %F{yellow}${prompt_pure_state[git_branch]}%f.)%F{green}${PURE_PROMPT_SYMBOL}%f "
}

prompt_pure_setup() {
    # Simplified prompt setup
    autoload -Uz add-zsh-hook
    prompt_opts=(cr percent sp subst)
    add-zsh-hook precmd prompt_pure_precmd
    add-zsh-hook preexec prompt_pure_preexec
    prompt_pure_state[prompt]=${PURE_PROMPT_SYMBOL:-❯}
    zle -N prompt_pure_update_vim_prompt_widget
    zle -N prompt_pure_reset_vim_prompt_widget
    PROMPT="%(12V.%F{blue}%12v%f .)%F{cyan}%~%f%(1V. %F{yellow}${prompt_pure_state[git_branch]}%f.)%F{green}${PURE_PROMPT_SYMBOL}%f "
}

# History configuration
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt inc_append_history
setopt hist_ignore_dups

# Basic completion system
autoload -Uz compinit
compinit -C

# Key bindings
bindkey -e

# Minimal aliases
alias l='ls'
alias ll='ls -l'
alias g='git'

# Basic directory navigation
setopt auto_cd
setopt auto_pushd

# Load pure prompt
autoload -U promptinit; promptinit
prompt pure

eval "$(zoxide init zsh)"
