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

  outputs =
    inputs@{ self
    , nixpkgs
    , nix-darwin
    , home-manager
    , nix-homebrew
    , ...
    }:
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
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./modules/yabai.nix
          ./modules/skhd.nix
          {
            nixpkgs.hostPlatform = system;
            nixpkgs.config.allowUnfree = true;

            system.primaryUser = username;
            users.users.${username} = {
              home = "/Users/${username}";
              shell = pkgs.zsh;
            };

            fonts.packages = [
              pkgs.nerd-fonts.blex-mono
            ];

            #         system.activationScripts.applications.text = let
            #         systemPackages = [
            #                 pkgs.alacritty
            #     pkgs.mkalias
            #   ];
            #         env = pkgs.buildEnv {
            #           name = "system-applications";
            #           paths = systemPackages;
            #           pathsToLink = "/Applications";
            #         };
            #       in
            #         pkgs.lib.mkForce ''
            #           # Set up applications.
            #           echo "setting up /Applications..." >&2
            #           rm -rf /Applications/Nix\ Apps
            #           mkdir -p /Applications/Nix\ Apps
            # find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            # while IFS= read -r src; do
            #   app_name=$(basename "$src")
            #   echo "Copying $src" >&2
            #   ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            # done
            #         '';

            # macOS system preferences
            system.defaults = {
              dock.autohide = true;
              dock.persistent-apps = [
                "/System/Applications/Launchpad.app"
                "/System/Applications/System Settings.app"
                "/Applications/Microsoft Excel.app"
                "/Applications/Microsoft PowerPoint.app"
                "/Applications/Microsoft Word.app"
                "/Applications/WhatsApp.app"
                "/Applications/Obsidian.app"
                "/Applications/VLC.app"
                "/Applications/Spotify.app"
                # "${pkgs.alacritty}/Applications/Alacritty.app"
                "/Applications/WezTerm.app"
                "/Applications/Xcode.app"
                "/Applications/Firefox.app"
              ];
              finder.FXPreferredViewStyle = "clmv"; # column view
              loginwindow.GuestEnabled = false;
              NSGlobalDomain.AppleICUForce24HourTime = false;
              NSGlobalDomain.AppleInterfaceStyle = "Dark";
              NSGlobalDomain.KeyRepeat = 2;
            };

            environment.systemPackages = with pkgs; [
              browserpass
              gnupg
              yabai
              skhd
              minikube
              kubectl
              tailscale
              # alacritty
              # mkalias
            ];

            homebrew = {
              enable = true;

              taps = [
                "amar1729/formulae"
              ];

              brews = [
                "node"
                "go"
                "git-graph"
                "sqlc"
                "lazygit"
                "golang-migrate"
                "ncdu"
                "browserpass"
                "bitwarden-cli"
              ];

              casks = [
                "openvpn-connect"
                "qbittorrent"
                "docker-desktop"
                "tailscale"
                "raycast"
                "whatsapp"
                "obsidian"
                "karabiner-elements"
                "anythingllm"
                "vlc"
                "wezterm"
                "spotify"
                "firefox"
              ];

              masApps = {
                Xcode = 497799835;
                # LocalSend = 1661733229;
              };

              onActivation.cleanup = "zap";
            };

            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
          }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.${username} = import ./home.nix {
              inherit
                pkgs
                config
                nixpkgs
                lib
                system
                inputs
                ;
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
