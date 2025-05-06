{
  config,
  pkgs,
  lib,
  ...
}:

let
  homeDirectory = "/Users/shahid";
  userGmail = "shahidshabbirse@gmail.com";
  userGithub = "shahidshabbir-se";
in
{
  home = {
    username = "shahid";
    homeDirectory = homeDirectory;
    stateVersion = "24.05";

    packages = with pkgs; [
      bat
      ripgrep
      fzf
      starship
      eza
      zoxide
      neovim
      tmux
      zsh
      stow
      gnupg
      atuin
    ];

  };

  programs = {
    git = import ./modules/git.nix {
      inherit
        config
        pkgs
        homeDirectory
        userGmail
        userGithub
        ;
    };

    password-store.enable = true;
  };
}
