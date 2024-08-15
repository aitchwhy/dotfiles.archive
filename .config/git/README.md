# Git global setup

https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

https://github.com/fffaraz/awesome-github?tab=readme-ov-file
https://github.com/mathiasbynens/dotfiles/blob/main/.macos
https://github.com/paulmillr/dotfiles

```shell

git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"


# link home dir file to config file (if needed) <--- TODO: this should be created by Nix+dotfiles
$ ln -s ~/src/dotfiles/config/git/.gitignore ~/.gitignore
# set global gitignore to "~/.gitignore" file
$ git config --global core.excludesfile ~/.gitignore
```

git config --global user.name "John Doe"

https://github.com/aanand/git-up

git-semver
git-secret
awesome-github
git-extras
git-extra-commands

lazygit
tig
