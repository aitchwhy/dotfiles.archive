{ inputs, lib, config, pkgs, ... }:

{
  # TODO: inputs.self, inputs.nix-darwin, and inputs.nixpkgs can be accessed here
  # nix-darwin module config options (https://daiderd.com/nix-darwin/manual/index.html)
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Use a custom configuration.nix location (https://github.com/LnL7/nix-darwin/wiki/Changing-the-configuration.nix-location)
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # $ nix run nix-darwin -- switch --flake ~/dotfiles/ ---- (nix-darwin is same as darwin-rebuild for some reason)
  environment.darwinConfig = "$HOME/dotfiles/darwin/darwin.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # system.stateVersion = 4;

  # nixpkgs.hostPlatform = lib.hostPlatform
  # nixpkgs.hostPlatform = inputs.nixpkgs  "aarch64-darwin";


  programs = {
    zsh.enable = true;
    # Create /etc/zshrc that loads the nix-darwin environment.
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

    # direnv = {
    #   enable = true;
    #   # enableBashIntegration = true; # see note on other shells below
    #   nix-direnv.enable = true;
    # };
  };

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

  # system = {
  #   defaults = {
  #     dock = {
  #       # autohide = true;
  #       # orientation = "left";
  #       # show-process-indicators = false;
  #       show-recents = false;
  #       # static-only = true;
  #     };
  #     finder = {
  #       AppleShowAllExtensions = true;
  #       # FXDefaultSearchScope = "SCcf";
  #       # FXEnableExtensionChangeWarning = false;
  #       ShowPathbar = true;
  #     };
  #     # NSGlobalDomain = {
  #     #   AppleKeyboardUIMode = 3;
  #     #   "com.apple.keyboard.fnState" = true;
  #     #   NSAutomaticWindowAnimationsEnabled = false;
  #     # };
  #   };
    # keyboard = {
    #   enableKeyMapping = true;
    #   remapCapsLockToControl = true;
    # };
  # };
}
