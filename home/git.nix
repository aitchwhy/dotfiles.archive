{...}:
{
  home.file = {
    ".gitignore".source = ../config/git/.gitignore;
    ".gitconfig".source = ../config/git/.gitconfig;
  };

  programs.git = {
    enable = true;

    lfs.enable = true;
  };
}
