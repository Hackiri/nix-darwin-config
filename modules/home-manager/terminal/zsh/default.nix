{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  shellAliases = import ./aliases.nix;
  dollar = "$";
  theme = {
    colors = {
      # Base colors
      bg = "#1a1b26";
      bg_dark = "#16161e";
      bg_highlight = "#292e42";
      terminal_black = "#414868";
      fg = "#c0caf5";
      fg_dark = "#a9b1d6";
      fg_gutter = "#3b4261";

      # UI elements
      dark3 = "#545c7e";
      comment = "#565f89";

      # Blues
      blue0 = "#3d59a1";
      blue = "#7aa2f7";
      cyan = "#7dcfff";
      blue1 = "#2ac3de";
      blue2 = "#0db9d7";
      blue5 = "#89ddff";
      blue6 = "#b4f9f8";
      blue7 = "#394b70";

      # Purples and pinks
      magenta = "#bb9af7";
      magenta2 = "#ff007c";
      purple = "#9d7cd8";

      # Warm colors
      orange = "#ff9e64";
      yellow = "#e0af68";

      # Greens
      green = "#9ece6a";
      green1 = "#73daca";
      green2 = "#41a6b5";
      teal = "#1abc9c";

      # Reds
      red = "#f7768e";
      red1 = "#db4b4b";
    };
  };
in {
  home = {
    sessionVariables = {
      KREW_ROOT = "${config.home.homeDirectory}/.krew";
      PATH = "${config.home.homeDirectory}/.krew/bin:${config.home.homeDirectory}/bin:$PATH";
      GIT_USER_NAME = "hackiri";
      GIT_USER_EMAIL = "128340174+Hackiri@users.noreply.github.com";
      EDITOR = "vim";
      VISUAL = "vim";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      TERM = "xterm-256color";
      # oh-my-zsh configuration
      ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
      ZSH_CUSTOM = "${config.home.homeDirectory}/.oh-my-zsh/custom";
      ZSH_CACHE_DIR = "${config.home.homeDirectory}/.cache/oh-my-zsh";
    };

    packages = with pkgs; [
      direnv
      fzf
      zoxide
      bat
      jq
      oh-my-zsh
      python3Packages.pygments # Required for syntax highlighting
      starship
    ];
  };

  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          ratio = [1 2 5];
        };
        theme = {
          manager = {
            tab_normal.bg = {hex = theme.colors.bg;};
            tab_normal.fg = {hex = theme.colors.comment;};
            tab_select.bg = {hex = theme.colors.bg;};
            tab_select.fg = {hex = theme.colors.blue;};
            border_symbol = "│";
            border_style.fg = {hex = theme.colors.blue0;};
            selection.bg = {hex = theme.colors.blue0;};
            selection.fg = {hex = theme.colors.fg;};
            status_normal.bg = {hex = theme.colors.bg;};
            status_normal.fg = {hex = theme.colors.fg_dark;};
            status_select.bg = {hex = theme.colors.blue0;};
            status_select.fg = {hex = theme.colors.fg;};
            folder.fg = {hex = theme.colors.blue;};
            link.fg = {hex = theme.colors.green1;};
            exec.fg = {hex = theme.colors.green;};
          };
          preview = {
            hovered.bg = {hex = theme.colors.bg_highlight;};
            hovered.fg = {hex = theme.colors.fg;};
          };
          input = {
            border.fg = {hex = theme.colors.blue;};
            title.fg = {hex = theme.colors.fg_dark;};
            value.fg = {hex = theme.colors.fg;};
            selected.bg = {hex = theme.colors.blue0;};
          };
          completion = {
            border.fg = {hex = theme.colors.blue;};
            selected.bg = {hex = theme.colors.blue0;};
          };
          tasks = {
            border.fg = {hex = theme.colors.blue;};
            selected.bg = {hex = theme.colors.blue0;};
          };
          which = {
            mask.bg = {hex = theme.colors.bg;};
            desc.fg = {hex = theme.colors.comment;};
            selected.bg = {hex = theme.colors.blue0;};
            selected.fg = {hex = theme.colors.fg;};
          };
        };
      };
    };

    lazygit = {
      enable = true;
      settings = {
        gui = {
          theme = {
            lightTheme = false;
            activeBorderColor = [theme.colors.green "bold"];
            inactiveBorderColor = [theme.colors.fg_dark];
            selectedLineBgColor = [theme.colors.blue0 "bold"];
          };
          showIcons = true;
          expandFocusedSidePanel = true;
        };
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      colors = {
        "bg+" = theme.colors.bg_highlight;
        "fg+" = theme.colors.fg;
        "hl+" = theme.colors.blue;
        hl = theme.colors.blue;
        header = theme.colors.comment;
        info = theme.colors.cyan;
        marker = theme.colors.red;
        pointer = theme.colors.magenta;
        prompt = theme.colors.yellow;
        spinner = theme.colors.magenta;
      };
    };

    bat = {
      enable = true;
      themes = {
        tokyo-night = {
          src = inputs.tokyonight;
          file = "extras/sublime/tokyonight_night.tmTheme";
        };
      };
      config = {
        theme = "tokyo-night";
        style = "numbers,changes,header";
        color = "always";
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };

    zsh = {
      enable = true;
      inherit shellAliases;
      enableCompletion = true;

      # Enable native plugins
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      historySubstringSearch.enable = true;

      history = {
        size = lib.mkForce 50000;
        save = lib.mkForce 50000;
        path = "${config.home.homeDirectory}/.zsh_history";
        ignoreDups = true;
        share = true;
        extended = true;
      };

      oh-my-zsh = {
        enable = true;
        package = pkgs.oh-my-zsh;
        theme = ""; # Disabled theme to use Starship instead
        plugins = [
          "git"
          "sudo"
          "history"
          "direnv"
          "fzf"
          "zoxide"
          "z"
          "extract"
          "colored-man-pages"
          "command-not-found"
          "aliases"
          "alias-finder"
          "common-aliases"
          "copypath"
          "copyfile"
          "copybuffer"
          "dirhistory"
          "docker"
          "docker-compose"
          "kubectl"
          "npm"
          "pip"
          "python"
          "rust"
          "golang"
          "macos"
          "vscode"
          "web-search"
          "jsontools"
        ];
      };

      initExtra = ''
        # Set a fixed path for the completion dump
        export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"

        # Ensure cache directory exists
        if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
          mkdir -p "$ZSH_CACHE_DIR"
        fi

        # Initialize zoxide with cd as the command
        eval "$(zoxide init zsh --cmd cd)"

        # FZF configuration
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_DEFAULT_OPTS="--height 50% -1 --layout=reverse --multi"

        # Use fd for FZF commands
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

        # Preview configuration
        show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
        export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
        export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

        # FZF completion functions
        _fzf_compgen_path() {
          fd --hidden --exclude .git . "$1"
        }

        _fzf_compgen_dir() {
          fd --type=d --hidden --exclude .git . "$1"
        }

        # Advanced FZF completion customization
        _fzf_comprun() {
          local command=$1
          shift

          case "$command" in
            cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
            export|unset) fzf --preview 'eval "echo ${dollar}{}"' "$@" ;;
            ssh)          fzf --preview 'dig {}'                   "$@" ;;
            *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
          esac
        }

        # FZF Git Integration Functions
        is_in_git_repo() {
          git rev-parse HEAD > /dev/null 2>&1
        }

        fzf-down() {
          fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
        }

        _gf() {
          is_in_git_repo || return
          git -c color.status=always status --short |
          fzf-down -m --ansi --nth 2..,.. \
            --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
          cut -c4- | sed 's/.* -> //'
        }

        _gb() {
          is_in_git_repo || return
          git branch -a --color=always | grep -v '/HEAD\s' | sort |
          fzf-down --ansi --multi --tac --preview-window right:70% \
            --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
          sed 's/^..//' | cut -d' ' -f1 |
          sed 's#^remotes/##'
        }

        _gt() {
          is_in_git_repo || return
          git tag --sort -version:refname |
          fzf-down --multi --preview-window right:70% \
            --preview 'git show --color=always {}'
        }

        _gh() {
          is_in_git_repo || return
          git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
          fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --header 'Press CTRL-S to toggle sort' \
            --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
          grep -o "[a-f0-9]\{7,\}"
        }

        _gr() {
          is_in_git_repo || return
          git remote -v | awk '{print $1 "\t" $2}' | uniq |
          fzf-down --tac \
            --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
          cut -d$'\t' -f1
        }

        _gs() {
          is_in_git_repo || return
          git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
          cut -d: -f1
        }

        join-lines() {
          local item
          while read item; do
            echo -n "''${(q)item} "
          done
        }

        bind-git-helper() {
          local c
          for c in $@; do
            eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
            eval "zle -N fzf-g$c-widget"
            eval "bindkey '^g^$c' fzf-g$c-widget"
          done
        }

        bind-git-helper f b t r h s
        unset -f bind-git-helper

        # Initialize Starship prompt
        eval "$(starship init zsh)"

        # Source oh-my-zsh
        if [ -f "$ZSH/oh-my-zsh.sh" ]; then
          source "$ZSH/oh-my-zsh.sh"
        else
          echo "Warning: oh-my-zsh.sh not found at $ZSH/oh-my-zsh.sh"
        fi

        # Basic configurations
        zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

        # Fix for zle warnings
        zmodload zsh/zle
        zmodload zsh/zpty
        zmodload zsh/complete

        # Advanced ZSH options
        setopt AUTO_CD
        setopt AUTO_PUSHD
        setopt PUSHD_IGNORE_DUPS
        setopt PUSHD_MINUS
        setopt EXTENDED_HISTORY
        setopt HIST_EXPIRE_DUPS_FIRST
        setopt HIST_IGNORE_DUPS
        setopt HIST_IGNORE_SPACE
        setopt HIST_VERIFY
        setopt SHARE_HISTORY
        setopt INTERACTIVE_COMMENTS
        setopt COMPLETE_IN_WORD
        setopt ALWAYS_TO_END
        setopt PATH_DIRS
        setopt AUTO_MENU
        setopt AUTO_LIST
        setopt AUTO_PARAM_SLASH
        setopt NO_BEEP
      '';

      profileExtra = ''
        if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
          . $HOME/.nix-profile/etc/profile.d/nix.sh
        fi
      '';
    };
  };
}
