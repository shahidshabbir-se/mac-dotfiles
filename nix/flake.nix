# flake.nix
{
  description = "Zenful nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nix-homebrew, ... }:
    let
      system = "aarch64-darwin";
      username = "shahid";
      hostname = "mini";
      lib = nixpkgs.lib;
      config = nixpkgs.config;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          {
            nixpkgs.hostPlatform = system;
            nixpkgs.config.allowUnfree = true;

            users.users.${username}.home = "/Users/${username}";

             fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

            # macOS system preferences
      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/System/Applications/System Settings.app"
          # "/Applications/Microsoft Excel.app"
          # "/Applications/Microsoft PowerPoint.app"
          # "/Applications/Microsoft Word.app"
          "/Applications/WhatsApp.app"
          "/Applications/Docker.app"
          "/Applications/Obsidian.app"
          "/Applications/VLC.app"
          "/Applications/Spotify.app"
          "/Applications/WezTerm.app"
          # "/Applications/Xcode.app"
          # "/Applications/PyCharm.app"
          "/Applications/Google Chrome.app"
        ];
        finder.FXPreferredViewStyle = "clmv"; # column view
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = false;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
      };

            environment.systemPackages = with pkgs; [
            ];

            homebrew = {
              enable = true;
              brews = ["node" ];
              casks = [ 
              "google-chrome" 
                "spotify"
          "wezterm"
          "docker"
          "alt-tab"
          "betterdisplay"
          "whatsapp"
          "obsidian"
          "vlc"
              ];
              masApps = { };
              onActivation.cleanup = "zap";
            };

            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            programs.zsh.enable = true;
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
          }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix {
                inherit pkgs config nixpkgs lib system inputs;
              };
          }

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = username;
              autoMigrate = true;
            };
          }
        ];
      };

      darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
    };
}

