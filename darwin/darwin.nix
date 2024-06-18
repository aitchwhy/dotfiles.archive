{ inputs, lib, config, pkgs, ... }:

#########################################
# NOTE: nix-darwin's Nix installation IS NOT THE SAME as system-wide Nix (https://github.com/LnL7/nix-darwin/wiki/Upgrading-Nix)
# - this is if using "nix.pkgs" input from "flake.nix"
# - need to ensure same settings (+ daemon) for system VS nix-darwin installations of Nix
#########################################
# NOTE: flake.nix that refers to this darwin.nix file CAN PASS INPUTS (https://github.com/LnL7/nix-darwin?tab=readme-ov-file#using-flake-inputs)
# - flake.nix : defines nix-darwin.lib.darwinSystem = {... specialArgs = {... inherits inputs ...} ...}
# - darwin.nix : accepts params (e.g. inputs) which were passed from flake.nix.
#     can use "inputs.self, inputs.nix-darwin, and inputs.nixpkgs"
#########################################
{

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages =
      [
        # pkgs.home-manager
        pkgs.vim
        # pkgs.bat
      ];

    variables = {
      EDITOR = "vim";
      # PAGER = "bat";
    };
  };

  # The custom path of the darwin configuration.nix used to configure the system, this updates the default darwin-config entry in NIX_PATH (https://daiderd.com/nix-darwin/manual/index.html#opt-environment.darwinConfig)
  # nix-darwin's Nix install (separate from system-wide) needs to know where darwin file is on 1st install so needs to be included with (-I "darwin-config=$HOME/...")
  # (1st   - remote) $ nix run nix-darwin -- switch -I "darwin-config=$HOME/dotfiles/darwin/darwin.nix" --flake "~/dotfiles"
  # ??(1st   - local ) nix run nix-darwin -- switch -I "darwin-config=$HOME/dotfiles/darwin/darwin.nix" --flake ~/dotfiles
  # ??(after         ) $ darwin-rebuild switch ....(same as 1st time)
  environment.darwinConfig = "$HOME/dotfiles/darwin/darwin.nix";

  # Auto upgrade nix package and the daemon service.
  services = {
    nix-daemon.enable = true;
  };

  # nix installation for nix-darwin (separate from system)
  nix = {
    package = pkgs.nix;
    # nix expression default search path (to look up <nixpkgs>) - default is (darwin-config ---> root nix channels path) so setting "environment.darwinConfig" to darwin.nix should be enough
    # nixPath = "";
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # TODO: configure right platform ( (https://daiderd.com/nix-darwin/manual/index.html#opt-nixpkgs.hostPlatform)
  # The platform the configuration will be used on.
  # nixpkgs.hostPlatform = lib.hostPlatform
  nixpkgs = {
    # platform where nix-darwin will run (ignored when nixpkgs.pkg is set)
    hostPlatform = "aarch64-darwin";
    # hostPlatform = inputs.nixpkgs.hostPlatform;
  };


  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # system.stateVersion = 4;

  # fonts.fontDir.enable = true;
  # fonts.fonts = [
  #   pkgs.atkinson-hyperlegible
  #   pkgs.jetbrains-mono
  # ];

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

  programs = {
    zsh = {
      enable = true;
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
    };

    # direnv = {
    #   enable = true;
    #   # enableBashIntegration = true; # see note on other shells below
    #   nix-direnv.enable = true;
    # };
  };


  # nix-darwin homebrew using brew bundler
  # homebrew options https://github.com/Homebrew/homebrew-bundle#usage
  homebrew = {
    enable = true;

    # brew options for when run by nix-darwin during system activation
    # onActivation = {
    #   # prefer to keep idempotency (no update+upgrade)
    #   autoUpdate = false;
    #   upgrade = false;
    #   # cleanup existing apps that are NOT included in brewfile (uninstall them)
    #   cleanup = "uninstall";
    #   extraFlags = [
    #     "--debug"
    #     "--verbose"
    #   ];
    # };


    # brew options when manually invoked
    global = {
      # TODO: update to use brewfile (? but is it necessary?)
      # brewfile = true
      autoUpdate = false;
    };


    # taps = [
      # "homebrew/bundle"
    # ];

    brews = [
      "hexyl"
    ];

    # args passed to all cask installs on list (https://docs.brew.sh/Manpage#global-cask-options)
    caskArgs = {
      appdir = "/Applications";
    };

    casks = [
      # "bitwarden"
      # "fantastical"
      # "obsidian"
      # "raycast"
      # "warp"
      # "qflipper"
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
