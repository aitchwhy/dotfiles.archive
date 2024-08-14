
############
# TODO - https://github.com/holman/dotfiles/blob/master/zsh/zshrc.symlink
# TODO - https://github.com/thornycrackers/nix-config/blob/master/src/bash/includes.sh
############
# # all of our zsh files
# typeset -U config_files
# config_files=($ZSH/**/*.zsh)
#
# # load the path files
# for file in ${(M)config_files:#*/path.zsh}
# do
#   source $file
# done
#
# # load everything but the path and completion files
# for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
# do
#   source $file
# done
#
# # initialize autocomplete here, otherwise functions won't be loaded
# autoload -U compinit
# compinit
#
# # load every completion after autocomplete loads
# for file in ${(M)config_files:#*/completion.zsh}
# do
#   source $file
# done
#
# unset config_files
############

#-------------------------------------------------------------------------------
# Shortcut paths (e.g dotfiles)
#-------------------------------------------------------------------------------
export DOTS=$HOME/src/dotfiles
export DOTS_ZSH=$DOTS/zsh
# export ZPLUG_HOME="~/.zplug"
# export DOTFILES_ALIASES=$DOTFILES_ZSH/aliases.zsh
# export DOTFILES_EXPORTS=$DOTFILES_ZSH/exports.zsh
# export DOTFILES_FUNCTIONS=$DOTFILES_ZSH/functions.zsh

#-----------
# homebrew
#-----------
export BREW_PREFIX="/opt/homebrew"
export BREWFILE_GLOBAL=${HOMEBREW_BUNDLE_FILE_GLOBAL:-$HOME/.Brewfile}

#-----------
# Preferred editor for local and remote sessions
#-----------
export EDITOR='nvim'

#-----------
# Zplug (zsh plugin manager) - init
#-----------

# Check if zplug is installed + install if not (check ~/.zplug dir)
if [[ ! -d ~/.zplug ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  # git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh
  # zplug update
fi

# INIT ZPLUG - Essential (needs to be here even if above "if" conditional not run)
source ~/.zplug/init.zsh

#################################################
# zsh zplug plugins list
#
# TODO: z.lua
# TODO: https://github.com/unixorn/zsh-quickstart-kit?tab=readme-ov-file#included-plugins
# TODO: https://github.com/bonnefoa/kubectl-fzf
#################################################

# NOTE: oh-my-zsh plugins like below (https://github.com/zplug/zplug/issues/436) + (https://github.com/zplug/zplug/issues/481) + (https://github.com/zplug/zplug/issues/239)
# zplug "robbyrussell/oh-my-zsh", as:plugin, use:"lib/*.zsh" 
# zplug "robbyrussell/oh-my-zsh", as:plugin, use:"lib/command-not-found" 

zplug "plugins/brew", from:oh-my-zsh, as:plugin, if:"(( $+commands[brew] ))"
zplug "zsh-users/zsh-completions"
zplug "plugins/command-not-found", from:oh-my-zsh, as:plugin
zplug "plugins/aliases", from:oh-my-zsh, as:plugin

zplug "ajeetdsouza/zoxide", as:plugin, if:"(( $+commands[zoxide] ))"
zplug "plugins/git", from:oh-my-zsh, as:plugin, if:"(( $+commands[git] ))"
zplug "plugins/git-extra-commands", from:oh-my-zsh, as:plugin if:"(( $+commands[git] ))"
# zplug 'wfxr/forgit', if:"(( $+commands[git] ))"

# zplug "junegunn/fzf", as:plugin, if:"(( $+commands[fzf] ))"
# zplug "urbainvaes/fzf-marks", if:"(( $+commands[fzf] ))"
# zplug "plugins/fzf-zsh-plugin", from:oh-my-zsh
# zplug "unixorn/fzf-zsh-plugin"

# zplug "plugins/nx-completion", from:oh-my-zsh

zplug "MichaelAquilina/zsh-you-should-use"
# suggest from (completions + history)
zplug "zsh-users/zsh-autosuggestions"
# zplug "marlonrichert/zsh-autocomplete", as:plugin # # https://www.reddit.com/r/zsh/comments/v08lsx/zshautocomplete_vs_zshautosuggestions_vs_fig/

# zplug "jeffreytse/zsh-vi-mode"
# zplug "olets/zsh-abbr"

# # Can manage local plugins (local ~/.zsh)
# aliases.zsh + functions.zsh + etc
# zplug "$DOTS_ZSH", from:local, use:".zsh"

# prompt (pure)
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", as:theme, use:pure.zsh

#################################################
# Install packages that have not been installed yet (zplug declarations from above)
#################################################

# install any uninstalled plugins
zplug check --verbose || zplug install

# # Install packages that have not been installed yet
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     else
#         echo
#     fi
# fi
#

#-----------
# Custom code (e.g. aliases)
#-----------
alias ls='ls --color=auto -al'
alias ll='ls -lah --color=auto'

alias ze="$EDITOR $HOME/.zshrc" # edit .zshrc
alias zs="source $HOME/.zshrc"  # reload zsh configuration

alias zp="zplug"
alias zph="zplug --help"
alias zpl="zplug --log"

source $DOTS_ZSH/aliases.symlink.zsh

# TODO (was working): zsh completions (https://thevaluable.dev/zsh-completion-guide-examples/)
# autoload -U compinit; compinit
# fpath="$(brew --prefix)/share/zsh/site-functions:${fpath}"

# if type brew &>/dev/null
# then
#   FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
#
#   autoload -Uz compinit
#   compinit
# fi


#################################################
# Then, source packages and add commands to $PATH
#################################################
zplug load --verbose

# fzf (homebrew pre-installed before this script)
# source <(fzf --zsh)


# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion


eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"

# Use vi keybindings even if our EDITOR is set to vi
# bindkey -v
# export KEYTIMEOUT=1

# # zsh cli edit with vim ($EDITOR)
# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# # zsh with vim surround feature
# autoload -Uz surround
# zle -N delete-surround surround
# zle -N add-surround surround
# zle -N change-surround surround
# bindkey -M vicmd cs change-surround
# bindkey -M vicmd ds delete-surround
# bindkey -M vicmd ys add-surround
# bindkey -M visual S add-surround

# # zsh with vim text objects
# autoload -Uz select-bracketed select-quoted
# zle -N select-quoted
# zle -N select-bracketed
# for km in viopp visual; do
#   bindkey -M $km -- '-' vi-up-line-or-history
#   for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
#     bindkey -M $km $c select-quoted
#   done
#   for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
#     bindkey -M $km $c select-bracketed
#   done
# done
# #
# # zsh vim mode visual color (normal vs insert modes)
# cursor_mode() {
#     # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
#     cursor_block='\e[2 q'
#     cursor_beam='\e[6 q'
#
#     function zle-keymap-select {
#         if [[ ${KEYMAP} == vicmd ]] ||
#             [[ $1 = 'block' ]]; then
#             echo -ne $cursor_block
#         elif [[ ${KEYMAP} == main ]] ||
#             [[ ${KEYMAP} == viins ]] ||
#             [[ ${KEYMAP} = '' ]] ||
#             [[ $1 = 'beam' ]]; then
#             echo -ne $cursor_beam
#         fi
#     }
#
#     zle-line-init() {
#         echo -ne $cursor_beam
#     }
#
#     zle -N zle-keymap-select
#     zle -N zle-line-init
# }
#
# cursor_mode

# ########################################################
# # TODO: https://thevaluable.dev/zsh-install-configure-mouseless/
# ########################################################
#
#
# ############
# # (Aug 2, 2024) Oh-my-zsh setup config files
# # - .zshrc
#
# ############
#
# #
# # # bun completions
# # [ -s "/Users/hank/.bun/_bun" ] && source "/Users/hank/.bun/_bun"
#
# # # bun
# # export BUN_INSTALL="$HOME/.bun"
# # export PATH="$BUN_INSTALL/bin:$PATH"
# source "$HOME/.rye/env"
# # eval "$(zellij setup --generate-auto-start zsh)"
# # eval "$(zellij setup zsh)"
# eval "$(zoxide init zsh)"
#
#
# source /Users/hank/.config/broot/launcher/bash/br

