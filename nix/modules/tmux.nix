{ pkgs, ... }:
let
  tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "master";
      sha256 = "sha256-TOS9+eOEMInAgosB3D9KhahudW2i1ZEH+IXEc0RCpU0=";
    };
  };
in
{
  enable = true;

  aggressiveResize = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  terminal = "screen-256color";
  newSession = true;
  secureSocket = true;
  shell = "${pkgs.zsh}/bin/zsh";

  plugins = with pkgs.tmuxPlugins; [
    tokyo-night
    yank
    sensible
    vim-tmux-navigator
  ];

  extraConfig = ''
    set -as terminal-features ",xterm-256color:RGB"
    set -g mouse on

    unbind C-b
    set -g prefix C-n
    bind C-n send-prefix

    # Vim style pane selection
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # Start windows and panes at 1, not 0
    set -g base-index 1
    set -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on

    # Bind clearing the screen
    bind L send-keys '^L'

    # Use Alt-arrow keys without prefix key to switch panes
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    # Shift arrow to switch windows
    bind -n S-Left previous-window
    bind -n S-Right next-window

    # Shift Alt vim keys to switch windows
    bind -n M-H previous-window
    bind -n M-L next-window

    set -g @tokyo-night-tmux_window_id_style hsquare
    set -g @tokyo-night-tmux_show_datetime 0
    set -g @tokyo-night-tmux_show_path 1
    set -g @tokyo-night-tmux_path_format relative
    set -g @tokyo-night-tmux_show_git 1
    set -g @tokyo-night-tmux_terminal_icon 
    set -g @tokyo-night-tmux_active_terminal_icon 
    set -g @tokyo-night-tmux_show_hostname 0
    set -g @tokyo-night-tmux_window_tidy_icons 0
    set -g @tokyo-night-tmux_transparent 1

    set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
    set -g @vim_navigator_mapping_right "C-Right C-l"
    set -g @vim_navigator_mapping_up "C-k"
    set -g @vim_navigator_mapping_down "C-j"
    set -g @vim_navigator_mapping_prev ""

    run-shell ${tokyo-night}/share/tmux-plugins/tokyo-night/tokyo-night.tmux

    # set vi-mode
    set-window-option -g mode-keys vi

    # keybindings
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    bind c new-window -c "#{pane_current_path}"

    # Set the shell inside tmux itself
    set -g default-shell "${pkgs.zsh}/bin/zsh"
    set -g default-command "${pkgs.zsh}/bin/zsh"

    
    set -as terminal-overrides ',wezterm:RGB'
    set -as terminal-features ",xterm-256color:RGB"
  '';
}
