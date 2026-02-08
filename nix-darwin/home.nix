{ config, pkgs, lib, ... }: {
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    tmux
    rustup
    smug
    oh-my-zsh 
    pnpm
    direnv
    git
    unzip
    gcc
    ripgrep
    gnumake
    lazygit
    zoom-us
    nodejs_22
    obsidian
    claude-code
    libiconv
    zlib
    _1password-cli
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.sessionVariables = {
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    LIBRARY_PATH = "${pkgs.libiconv}/lib:${pkgs.zlib}/lib";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.neovim = {
      enable = true;
      withNodeJs = true;
  };

  programs.tmux = {
    enable = true;

    # --- Basic Settings ---
    # Replaces: set -g prefix C-a
    prefix = "C-a";

    shell = "${pkgs.zsh}/bin/zsh";

    # --- Environment Fix ---
    # Solves the problem of tmux sessions having a stale environment
    # updateEnvironment = true;

    # --- Plugin Management ---
    # This section replaces TPM and all `set -g @plugin '...'` lines.
    # Home Manager is now your plugin manager.
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];

    # --- The Catch-All for Everything Else ---
    # Any command that doesn't have a dedicated option goes here.
    extraConfig = ''
      # --- Custom Keybindings ---
      # Replaces: unbind r / bind r ...
      # Note: The "Nix way" to reload is `home-manager switch`, but this
      # binding is kept for convenience during quick edits.
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      set-option -g default-command "${pkgs.zsh}/bin/zsh"

      # Replaces: bind -n M-] next-window / bind -n M-[ previous-window
      bind -n M-] next-window
      bind -n M-[ previous-window

      # --- Plugin Settings ---
      # Replaces: set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-strategy-vim 'session'
      # Replaces: set -g @resurrect-strategy-nvim 'session'
      set -g @resurrect-strategy-nvim 'session'
      # Replaces: set -g @continuum-restore 'on'
      set -g @continuum-restore 'on'
    '';
  };


  programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
   };


  programs.smug.enable = true;
  # programs.smug.projects = {
  #   test = {
  #     root = "~/Develop/";
  #     windows = [
  #       {
  #         name = "code";
  #         manual = true;
  #         layout = "main-vertical";
  #       }
  #     ];
  #   };
  # };

  programs.zsh = {
    enable = true;
    # dotDir = "$HOME/.config/zsh/";
    initContent = lib.mkOrder 1200 "alias drs=\"darwin-rebuild switch --flake ~/.config/nix-darwin\"";
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "direnv" ];
      theme = "robbyrussell";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "0e810e5afa27acbd074398eefbe28d13005dbc15";
          hash = "sha256-85aw9OM2pQPsWklXjuNOzp9El1MsNb+cIiZQVHUzBnk=";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "babarot";
          repo = "enhancd";
          rev = "5afb4eb6ba36c15821de6e39c0a7bb9d6b0ba415";
          hash = "sha256-pKQbwiqE0KdmRDbHQcW18WfxyJSsKfymWt/TboY2iic=";
        };
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "77a4f9c1343d12d7cb3ae1e7efc7c37397ccb6b0";
          hash = "sha256-YH5T9a9KbYbvY6FRBITlhXRmkTmnwGyCQpibLe3Dhwc=";
        };
      }
    ];
  };
}

