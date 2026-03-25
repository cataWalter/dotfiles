# ==========================================
# ENVIRONMENT VARIABLES & PATHS
# ==========================================
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Applications/PyCharm CE.app/Contents/MacOS:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"

# Python & UV
export PYTHONHTTPSVERIFY=0
export UV_TLS_INSECURE=true

# Java & Maven
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@21/21.0.10/libexec/openjdk.jdk/Contents/Home
export MAVEN_HOME=/opt/homebrew/Cellar/maven/3.9.12/libexec

# Homebrew Fixes
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_CASK_OPTS="--no-quarantine"

# ==========================================
# ALIASES
# ==========================================
alias python="python3"
alias pip="/opt/homebrew/bin/pip3.12"
alias ls='ls -G'
alias ll='ls -lhG'
alias gitamend="git add .; git commit --amend --no-edit; git push -f"

# ==========================================
# PLUGINS & PROMPT
# ==========================================
# Hardcoded brew path for maximum speed
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load ~/.zsh_plugins.txt

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# ==========================================
# SHELL OPTIONS
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Load local environment if it exists[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"