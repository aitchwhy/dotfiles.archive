##################################################
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#######################################################################
# User configuration
#######################################################################
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
EDITOR=nvim

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
####################################
# plugins with autoupdate enabled - https://lazyren.github.io/devlog/oh-my-zsh-setup.html#omz-plugins
####################################
plugins=(aliases git gh jsontools common-aliases globalias zsh-syntax-highlighting vscode zoxide urltools tmuxinator tmux themes rsync ripgrep nvm git git-commit git-extras git-flow gitignore git-prompt httpie isodate macos frontend-search fastfile fd fancy-ctrl-z dash colorize zsh-autosuggestions fzf fzf-zsh-plugin eza)

# TODO: fzf-tab
# TODO: homebrew
# TODO: direnv + nvm
# TODO: plugin zsh-autosuggestions
# TODO: plugin fzf-zsh-plugin
# TODO: plugin (zsh-navigation-tools)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# (Hank)
#
# #########################

#############################################
# TODO: custom functions + aliases

# TODO: shell CLI
# zsh + omz (paths + commands + aliases + functions)
# - omz plugins line by line list FZF (+  with description text if possible)
# dotfiles (Nix / asdf / mise-ee-place / Homebrew)
# secrets (bitwarden util cli + authy, etc)
# file/dir navigation + search (file, dir, content, etc)
# env files (dotenv + dotenvx)
# iterm/other + tmux
# shell history (atuin)
# fzf + shell completions
# Monorepo + automation + scripting

# TODO: EDITOR (Vim+neovim) + IDE (VSCode / zed)
# - vi-mode
# - vim-interaction
# - fancy-ctrl-z
# VSCode
# Zed
# Raycast

# TODO: data format manipulation (e.g. JSON - edit + reload + update in place)
# - JSON
# - CSV
# - YAML
# - ISO date
# - URL string
# JWT

# TODO: Databases  (e.g. postgres)
# Sysadmin (sudo, man, clipboard, vim, rsync, systemd, ssh)
# containers (docker, k8s, etc) + cloud hosting (aws, gcp, azure, etc)
# Git

# TODO: Docs (linux man pages, Mac Apps, APIs like stripe, etc)
# code docs (dash)
# keyboard shortcuts
# cheatsheets
# - frontend_search

# TODO: Language specific
# JS + TS
# Nodejs + nvm
# python + pyenv + poetry
# golang
# rust
# language (completions + linting + autogen)

# TODO: Git VCS (git, gitflow, git-extras, git-prompt, gitignore, git-commit)
# git
# gitflow
# conventions commits
# semver
# precommit+etc hooks

# TODO: AI tools
# shellgpt (from CLI)
# git PRs (Aider)

#############################################

#############################################
# Install custom packages
#############################################

# basic
export DOTFILES="$HOME/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export WORKSPACE="$HOME/workspace"
export EDITOR="nvim"

alias vim='nvim'
alias ls='eza --all --long'

# Atuin.sh installation
if ! command -v atuin &>/dev/null; then
    echo "Installing atuin CLI tool..."
    bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
fi

alias zsh_config="nvim ~/.zshrc"
alias tmux_config="nvim ~/.tmux.conf"
alias nvim_config="nvim ~/.config/nvim/init.vim"
alias zplugs="omz plugin list"
alias zplugs_dir="eza -a -l $ZSH/plugins"
alias zcplugs_dir="eza -a -l $ZSH_CUSTOM/plugins"

alias dots_dir="eza -a -l ~/dotfiles/"

alias ls='eza -al'
alias grep='rg'
alias find='fd'
# TODO: find a way to make this work with alias - NVM script (NVM_DIR/.nvm.sh) expects "sed" and provides some specific flags that are not in "sd"
# alias sed='sd'
alias diff='delta'
alias cat='bat'
alias du='dust -X .git'
alias ps='procs'
alias top='htop'
alias ping='prettyping --nolegend'
alias help='tldr'
alias reloadcli='omz reload'

# export NVM_HOMEBREW="/opt/homebrew/opt/nvm"

#-------------------------------------------------------------------------------
# Improving CLI toolset (more modern tooling)
# - https://remysharp.com/2018/08/23/cli-improved
# - https://news.ycombinator.com/item?id=26559334
#-------------------------------------------------------------------------------
# export PATH="$HOME/.local/bin:$PATH"

# Custom functions
# source "$SCRIPTS/.functions.sh"
#
########################
# OMZ fzf

source <(fzf --zsh)

export FZF_BASE="/opt/homebrew/opt/fzf"
########################

########################
# OMZ Pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
########################

#-------------------------------------------------------------------------------
# FZF
#-------------------------------------------------------------------------------
# export FZF_DEFAULT_COMMAND="rg --no-ignore-vcs --hidden --files $WORKDIR_PATHS"
# export FZF_DEFAULT_COMMAND="fd . $HOME"
# export FZF_DEFAULT_COMMAND="fd --hidden --no-ignore --type file --files "
# export FZF_DEFAULT_OPTS="
#   --multi
#   --layout=reverse
#   --inline-info
#   --border"

#-------------------------------------------------------------------------------
# Tmux fzf gnu-sed (gsed) path
#-------------------------------------------------------------------------------
# export TMUX_FZF_SED="/usr/local/bin/gsed"

#-------------------------------------------------------------------------------
# Justfile
#-------------------------------------------------------------------------------
export USER_JUSTFILE_NAME=".user.justfile"
export USER_JUSTFILE_PATH="~/.user.justfile"

#########################
#########################
# Ctrl+t -> FILES-only search and paste into CLI
#########################
#########################

# # Preview file content using bat (https://github.com/sharkdp/bat)
# export FZF_CTRL_T_COMMAND="rg --no-ignore-vcs --hidden --files $WORKDIR_PATHS"
# # FZF_CTRL_T_OPTS to ADD ADDITIONAL options if desired
# export FZF_CTRL_T_OPTS="
#   --preview 'bat -n --color=always {}'
#   --bind 'ctrl-/:change-preview-window(down|hidden|)'
#   --header 'Paste selected into shell CLI. All files (rg)'"
# #########################
# #########################
# # Ctrl+r -> shell command history (zsh) search and paste into CLI
# # NOTE: press Ctrl+r again to SORT toggle (relevance + time)
# # NOTE: "alt" == "option" key in Mac
# #########################
# #########################
# # FZF_CTRL_R_OPTS if we want more options (ADDITIONAL) for Ctrl+r
# # CTRL-/ to toggle small preview window to see the full command
# # CTRL-Y to copy the command into clipboard using pbcopy
# export FZF_CTRL_R_OPTS="
# --preview 'echo {}' --preview-window up:3:hidden:wrap
# --bind 'ctrl-/:toggle-preview'
# --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
# --color header:italic
# --header 'Paste selected Shell command. Press CTRL-Y to copy command into clipboard'"
# #########################
# # Esc+c -> search and CD into directory
# # NOTE: updated at iTerm2 level to use "Esc" as "Option" -> https://github.com/junegunn/fzf/issues/164
# # NOTE: press Ctrl+r again to SORT toggle (relevance + time)
# #########################
# # FZF_ALT_C_COMMAND -> to override Alt+c command
# # FZF_ALT_C_OPTS -> to pass ADDITIONAL Alt+c options
# export FZF_ALT_C_COMMAND="fd -t d . $HOME"
# # Print tree structure (-C means "colored") in the preview window
# export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# powerlevel10k
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

source $ZSH/oh-my-zsh.sh
###########################################################################
#
###########################################################################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${%:-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${%:-%n}.zsh"
fi

export DOTFILES="$HOME/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export WORKSPACE="$HOME/workspace"

source "$SCRIPTS/.functions.sh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

#######################################
# aliases
#######################################
#-------------------------------------------------------------------------------
# Git (sensible aliases + https://hackernoon.com/be-125-more-efficient-with-git-60556a1ce971)
#   - smart shortcut (frequenty usage)  ->  (g${short-command} - like gl for [git log]
#   - MOST of these will be overridden by functions in ".functions.sh"
#-------------------------------------------------------------------------------

# # GIT CONFIG
# alias gcnf='git config'

# # GIT STATUS
# alias gs='git status'

# # GIT log
# # .function gl

# # GIT BRANCH
# # .function gb()
# # .function gba()
# alias gbd='git branch -d'
# alias gbdd='git push origin --delete'

# # GIT CHECKOUT
# alias gco='git checkout $(gb)'   # command single quoted to avoid execution before alias call
# alias gcoa='git checkout $(gba)' # command single quoted to avoid execution before alias call
# alias gcob="git checkout -b"

# # GIT ADD
# alias ga='git add -i'
# alias gaa='git add --all'
# alias gap='git add --patch'

# # GIT COMMIT
# alias gc='git commit -v'
# alias gc!='git commit -v --amend'
# # -a option : auto stage ("add") added/modified but don't mind files not known to git
# alias gca='git commit -v -a'
# alias gca!='git commit -v -a --amend'

# # GIT BLAME
# alias gbl='git blame'

# # GIT STASH
# alias gst='git stash'

# # GIT PUSH
# # .function gsh()

# # GIT PULL
# alias gll='git pull'

# # GIT DIFF
# alias gd='git diff'

# # GIT worktree
# alias gw='git worktree'

# # GIT MERGE
# alias gm='git merge'
# alias gma='git merge --abort'

# # GIT REBASE (useful for squashing commits too) -- Squashing 4 commits (git rebase -i HEAD~4)
# # alias gr="git rebase"
# alias gri='git rebase -i'
# alias gra='git rebase --abort'
# alias grc='git rebase --continue'


# Git aliases + tooling


# #-------------------------------------------------------------------------------
# # Improving CLI toolset (more modern tooling)
# # - https://remysharp.com/2018/08/23/cli-improved
# # - https://news.ycombinator.com/item?id=26559334
# #-------------------------------------------------------------------------------

# alias grep='rg'
# alias find='fd'
# # TODO: find a way to make this work with alias - NVM script (NVM_DIR/.nvm.sh) expects "sed" and provides some specific flags that are not in "sd"
# # alias sed='sd'
# alias diff='delta'
# alias ls='eza -al'
# alias cat='bat'
# alias du='dust -X .git'
# alias ps='procs'
# alias top='htop'
# alias ping='prettyping --nolegend'
# alias help='tldr'
# alias xxd='hexyl'

NVM_HOMEBREW=$(brew --prefix nvm).

#-------------------------------------------------------------------------------
# FZF
#-------------------------------------------------------------------------------
# export FZF_DEFAULT_COMMAND="rg --no-ignore-vcs --hidden --files $WORKDIR_PATHS"
export FZF_DEFAULT_COMMAND="fd . $HOME"
# export FZF_DEFAULT_COMMAND="fd --hidden --no-ignore --type file --files $WORKDIR_PATHS"
export FZF_DEFAULT_OPTS="
  --multi
  --layout=reverse
  --inline-info
  --border"

#-------------------------------------------------------------------------------
# Tmux fzf gnu-sed (gsed) path
#-------------------------------------------------------------------------------
export TMUX_FZF_SED="/usr/local/bin/gsed"

#-------------------------------------------------------------------------------
# Justfile
#-------------------------------------------------------------------------------
export USER_JUSTFILE_NAME=".user.justfile"
export USER_JUSTFILE_PATH="~/.user.justfile"

#########################
#########################
# Ctrl+t -> FILES-only search and paste into CLI
#########################
#########################
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_COMMAND="rg --no-ignore-vcs --hidden --files $WORKDIR_PATHS"
# FZF_CTRL_T_OPTS to ADD ADDITIONAL options if desired
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --header 'Paste selected into shell CLI. All files (rg)'"
#########################
#########################
# Ctrl+r -> shell command history (zsh) search and paste into CLI
# NOTE: press Ctrl+r again to SORT toggle (relevance + time)
# NOTE: "alt" == "option" key in Mac
#########################
#########################
# FZF_CTRL_R_OPTS if we want more options (ADDITIONAL) for Ctrl+r
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Paste selected Shell command. Press CTRL-Y to copy command into clipboard'"
#########################
# Esc+c -> search and CD into directory
# NOTE: updated at iTerm2 level to use "Esc" as "Option" -> https://github.com/junegunn/fzf/issues/164
# NOTE: press Ctrl+r again to SORT toggle (relevance + time)
#########################
# FZF_ALT_C_COMMAND -> to override Alt+c command
# FZF_ALT_C_OPTS -> to pass ADDITIONAL Alt+c options
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
# Print tree structure (-C means "colored") in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
#########################



# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
########################
# OMZ fzf-tab (https://github.com/Aloxaf/fzf-tab/wiki/Configuration)
###
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux integration (ftb-tmux-popup)
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

########################

########################
# OMZ fzf
source <(fzf --zsh)
export FZF_BASE="$(brew --prefix fzf)/fzf"

# use Ctrl+T to trigger fzf-tab
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion
########################

########################
# OMZ Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
########################

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
####################################
# plugins with autoupdate enabled - https://lazyren.github.io/devlog/oh-my-zsh-setup.html#omz-plugins
####################################
plugins=(aliases git gh fzf jsontools autoupdate alias-finder common-aliases globalias zsh-autosuggestions zsh-syntax-highlighting vscode zoxide urltools tmuxinator tmux themes rsync ripgrep pyenv nvm git git-commit git-extras git-flow gitignore git-prompt httpie isodate macos fzf frontend-search fastfile fd fancy-ctrl-z dash direnv colorize brew zsh-navigation-tools zsh-autosuggestions fzf fzf-tab dotbare fzf-zsh-plugin)

# OMZ plugin alias-finder (https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder)
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# powerlevel10k
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"


source $ZSH/oh-my-zsh.sh
eval "$(atuin init zsh)"

PATH="$HOME/.local/bin:$PATH"
alias vim='nvim'




. "$HOME/.atuin/bin/env"
