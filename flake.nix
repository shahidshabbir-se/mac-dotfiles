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
          {
            nixpkgs.hostPlatform = system;
            nixpkgs.config.allowUnfree = true;

            system.primaryUser = username;
            users.users.${username}.home = "/Users/${username}";

            # services.yabai = {
            #   enable = true;
            #   enableScriptingAddition = true;
            #   package = pkgs.yabai;
            #   config = {
            #     layout = "bsp";
            #     window_placement = "second_child";
            #     top_padding = 10;
            #     bottom_padding = 10;
            #     left_padding = 10;
            #     right_padding = 10;
            #     window_gap = 10;
            #     mouse_follows_focus = "on";
            #     mouse_modifier = "alt";
            #     mouse_action1 = "move";
            #     mouse_action2 = "resize";
            #   };
            #
            #   extraConfig = ''
            #     yabai -m rule --add app="^System Settings$" manage=off
            #     yabai -m rule --add app="^Calculator$" manage=off
            #     yabai -m rule --add app="^Karabiner-Elements$" manage=off
            #     yabai -m rule --add app="^Google Chrome$" space=1
            #     yabai -m rule --add app="^WezTerm$" space=2
            #     yabai -m rule --add app="^Spotify$" space=9
            #
            #     yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
            #   '';
            # };

            services.skhd = {
              enable = true;
              skhdConfig = ''
                #################################
                #          SYSTEM KEYS          #
                #################################

                cmd + alt - r : skhd --restart-service
                cmd + alt - y : yabai --restart-service
                ctrl + cmd - l : osascript -e 'tell application "System Events" to keystroke "q" using {command down, control down}'

                shift + cmd - 1 : yabai -m window --space 1; yabai -m space --focus 1
                shift + cmd - 2 : yabai -m window --space 2; yabai -m space --focus 2
                shift + cmd - 3 : yabai -m window --space 3; yabai -m space --focus 3
                shift + cmd - 4 : yabai -m window --space 4; yabai -m space --focus 4
                shift + cmd - 5 : yabai -m window --space 5; yabai -m space --focus 5
                shift + cmd - 6 : yabai -m window --space 6; yabai -m space --focus 6
                shift + cmd - 7 : yabai -m window --space 7; yabai -m space --focus 7
                shift + cmd - 8 : yabai -m window --space 8; yabai -m space --focus 8
                shift + cmd - 9 : yabai -m window --space 9; yabai -m space --focus 9

                #################################
                #       APPLICATION BINDS       #
                #################################

                cmd - b : open -na "Google Chrome" && yabai -m space --focus 1
                cmd - m : open -na "Spotify" && yabai -m space --focus 9
                cmd - return : open -na "Wezterm" && yabai -m space --focus 2
                cmd - q : yabai -m window --close
              '';
            };

            fonts.packages = [
              pkgs.nerd-fonts.jetbrains-mono
              pkgs.nerd-fonts.geist-mono
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
                "/Applications/Google Chrome.app"
              ];
              finder.FXPreferredViewStyle = "clmv"; # column view
              loginwindow.GuestEnabled = false;
              NSGlobalDomain.AppleICUForce24HourTime = false;
              NSGlobalDomain.AppleInterfaceStyle = "Dark";
              NSGlobalDomain.KeyRepeat = 2;
            };

            environment.systemPackages = with pkgs; [
              tmux
              bat
              ripgrep
              browserpass
              fzf
              eza
              zoxide
              neovim
              zsh
              stow
              gnupg
              atuin
              bc
              coreutils
              jq
              yazi
              yabai
              skhd
              # alacritty
              # mkalias
            ];

            homebrew = {
              enable = true;

              taps = [
                "amar1729/formulae"
                "nikitabobko/tap"
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
                "aerospace"
                "qbittorrent"
                "orbstack"
                "raycast"
                "whatsapp"
                "obsidian"
                "karabiner-elements"
                "vlc"
                "wezterm"
                "spotify"
                "google-chrome"
              ];

              masApps = {
                Xcode = 497799835;
              };

              onActivation.cleanup = "zap";
            };

            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            programs.zsh.enable = true;
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
          }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
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
