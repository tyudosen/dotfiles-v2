{ config, pkgs, lib, ... }: {
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    tmux
    smug
    oh-my-zsh 
    pkgs.pnpm_10
    direnv
    git
    unzip
    gcc
    ripgrep
    gnumake
    lazygit
  ];

  home.sessionVariables = {
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
  };

  programs.neovim = {
      enable = true;
      withNodeJs = true;
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

