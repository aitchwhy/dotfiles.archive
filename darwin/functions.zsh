# custom functions
# symlink
slink() {
    local src_orig=$1
    local dst_link=$2
    local dst_dir=$(dirname "$dst_link")

    # Create the directory if it does not exist
    mkdir -p "$dst_dir"

    # Create the symlink
    ln -nfs "$src_orig" "$dst_link"
}

slink_dotfiles() {
    slink $DOTFILES_EXPORTS $OMZ_CUSTOM/exports.zsh
    slink $DOTFILES_ALIASES $OMZ_CUSTOM/aliases.zsh
    slink $DOTFILES_FUNCTIONS $OMZ_CUSTOM/functions.zsh
}
