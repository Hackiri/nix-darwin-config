{
  config,
  lib,
  pkgs,
  ...
}: let
  zshDotDir = ".config/zsh";
  shellAliases = import ./aliases.nix;
in {
  home.sessionVariables = {
    KREW_ROOT = "${config.home.homeDirectory}/.krew";
    PATH = "${config.home.homeDirectory}/.krew/bin:${config.home.homeDirectory}/bin:$PATH";
    GIT_USER_NAME = "hackiri";
    GIT_USER_EMAIL = "128340174+Hackiri@users.noreply.github.com";
  };

  programs = {
    zsh = {
      enable = true;
      inherit shellAliases;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
      history.path = "${config.home.homeDirectory}/.zsh_history";
      dotDir = zshDotDir;
      oh-my-zsh = {
        enable = true;
        theme = ""; # We're using starship instead
        plugins = [
          "git" # Git is usually available
          "sudo" # No dependencies needed
          "history" # No dependencies needed
          "direnv" # Will be installed via home.packages
          "copypath" # No dependencies needed
          "copyfile" # No dependencies needed
          "extract" # No dependencies needed
          "z" # No dependencies needed
          "macos" # macOS specific, no extra deps
        ];
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
          };
        }
      ];

      initExtra = ''
        # Basic configurations
        zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

        # Initialize Starship
        eval "$(starship init zsh)"

        # Fix for zle warnings
        zmodload zsh/zle
        zmodload zsh/zpty
        zmodload zsh/complete

        setopt interactive_comments bashautolist nobeep nomenucomplete \
                noautolist extended_glob
      '';
    };

    starship = {
      enable = lib.mkForce true;
      enableZshIntegration = lib.mkForce true;
      settings = lib.mkForce {};
    };
  };

  # Install necessary packages for plugins
  home.packages = with pkgs; [
    direnv
    fzf
  ];

  xdg.configFile."starship.toml" = {
    source = ./themes/jetpack.toml;
  };
}
