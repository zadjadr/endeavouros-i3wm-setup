# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH="/usr/share/oh-my-zsh/"

#ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='vim'
export VISUAL='vim'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias l='eza -l --icons'
alias ls='eza -la --icons'
alias lt='eza -a --tree --level=1 --icons'

alias gpr='git pull -pr'
alias gpu='git push'
alias grbi='git rebase -i'
alias grb='git rebase'
alias k='kubectl'
#alias yay='paru'
#alias yeet='paru -Rcs'
alias yeet='yay -Rcs'
alias lpass='source lpass'
alias bwu='bw unlock --passwordenv BW_PASSWORD'

export GPG_TTY=$(tty)
export GNUPGHOME=$HOME/.gnupg

# Use gnome-keyring ssh-agent
# export GNOME_KEYRING_CONTROL=/run/user/1000/keyring
# export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/keyring/ssh
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# PATH
export PATH=$HOME/.local/bin:$HOME/go/bin:$HOME/bin:$HOME/.cargo/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.linkerd2/bin:$HOME/.local/pipx/venvs:$PATH

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Atuin
ATUIN_NOBIND=1 eval "$(atuin init zsh --disable-up-arrow)"
bindkey '^r' _atuin_search_widget

# Direnv
eval "$(direnv hook zsh)"

# Fix zsh-syntax-highlight bug
# https://github.com/alacritty/alacritty/issues/4357
export TERM=xterm-256color

export PASSWORD_STORE_DIR=/mnt/BACKUP/Documents/.config/ioki/terraform.envrc
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

kubeconfig_path="$HOME/.kube/creds/"

# Check if the directory exists
if [ -d "$kubeconfig_path" ]; then
  # List all files in the directory and concatenate them with ":"
  kubeconfig_files=$(find "$kubeconfig_path" -mindepth 1 -type f| tr '\n' ':')

  # Remove the trailing ":" if there are files
  kubeconfig_files=${kubeconfig_files%:}

  # Append the concatenated files to the KUBECONFIG environment variable
  export KUBECONFIG="$kubeconfig_files"
else
  echo "Directory $kubeconfig_path does not exist."
fi

eval "$(starship init zsh)"
