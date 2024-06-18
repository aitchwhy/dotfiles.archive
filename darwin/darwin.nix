{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/src/github.com/evantravers/dotfiles";
  # environment.darwinConfig = "$HOME/dotfiles";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };
  # # zsh is the default shell on Mac and we want to make sure that we're
  # # configuring the rc correctly with nix-darwin paths.
  # programs.zsh.enable = true;
  # programs.zsh.shellInit = ''
  #   # Nix
  #   if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  #     . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  #   fi
  #   # End Nix
  #   '';


  # fonts.fontDir.enable = true;
  # fonts.fonts = [
  #   pkgs.atkinson-hyperlegible
  #   pkgs.jetbrains-mono
  # ];

  # # Used for backwards compatibility, please read the changelog before changing.
  # # $ darwin-rebuild changelog
  # system.stateVersion = 4;

  # services = {
    # yabai = {
    #   enable = true;
    #   config = {
    #     layout = "bsp";
    #     mouse_modifier = "ctrl";
    #     mouse_drop_action = "stack";
    #     window_shadow = "float";
    #     window_gap = "20";
    #   };
    #   extraConfig = ''
    #     yabai -m signal --add event=display_added action="yabai -m rule --remove label=calendar && yabai -m rule --add app='Fantastical' label='calendar' display=east" active=yes
    #     yabai -m signal --add event=display_removed action="yabai -m rule --remove label=calendar && yabai -m rule --add app='Fantastical' label='calendar' native-fullscreen=on" active=yes
    #     yabai -m rule --add app='OBS' display=east
    #     yabai -m rule --add app='Spotify' display=east

    #     yabai -m rule --add app='Cardhop' manage=off
    #     yabai -m rule --add app='Pop' manage=off
    #     yabai -m rule --add app='System Settings' manage=off
    #     yabai -m rule --add app='Timery' manage=off
    #   '';
    # };
  # };

  homebrew = {
    enable = true;

    casks = [
      "bitwarden"
      "fantastical"
      "obsidian"
      "raycast"
      "warp"
    ];

    # masApps = {
    #   "Drafts" = 1435957248;
    #   "Reeder" = 1529448980;
    #   "Things" = 904280696;
    #   "Timery" = 1425368544;
    # };
  };

  system = {
    defaults = {
      dock = {
        # autohide = true;
        # orientation = "left";
        # show-process-indicators = false;
        show-recents = false;
        # static-only = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        # FXDefaultSearchScope = "SCcf";
        # FXEnableExtensionChangeWarning = false;
        ShowPathbar = true;
      };
      # NSGlobalDomain = {
      #   AppleKeyboardUIMode = 3;
      #   "com.apple.keyboard.fnState" = true;
      #   NSAutomaticWindowAnimationsEnabled = false;
      # };
    };
    # keyboard = {
    #   enableKeyMapping = true;
    #   remapCapsLockToControl = true;
    # };
  };
}
