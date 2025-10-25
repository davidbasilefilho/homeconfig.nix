{ config, pkgs, ... }:

let
  gitconfig = builtins.fromTOML (builtins.readFile "${config.xdg.configHome}/home-manager/gitconfig.toml");
in {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
    nerd-fonts.geist-mono
    adwaita-fonts
    ghostty
    neovim
    fzf
    gnumake
    gcc
    fd
    ripgrep
  ];

  home.shell = {
    enableBashIntegration = true;
  };

  home.shellAliases = {
    ls = "eza -lah";
    ".." = "cd ..";
    "..." = "cd ../..";
  };

  fonts.fontconfig.enable = true;
  fonts.fontconfig.antialiasing = true;

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      profileExtra = ''
        export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
        export PATH="$PATH:$HOME/.bun/bin"
      '';
      initExtra = ''
        shopt -s autocd
      '';
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      colors = "always";
      git = true;
      icons = "always";
      extraOptions = [
        "--group-directories-first"
        "-lah"
      ];
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };

    mise = {
      enable = true;
      enableBashIntegration = true;
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
    };

    zed-editor = {
      enable = true;
      extensions = [
        "biome"
        "php"
        "mcp-server-context7"
        "mcp-server-sequential-thinking"
      ];
      userKeymaps = [
        {
          context = "Editor && vim_mode == insert";
          bindings = {
            "j k" = "vim::NormalBefore";
            ctrl-e = "vim::NormalBefore";
          };
        }
        {
          context = "Editor && vim_mode == normal";
          bindings = {
            "shift shift" = "file_finder::Toggle";
          };
        }
      ];
      userSettings = {
        vim_mode = true;
        features = {
          copilot = true;
          edit_prediction_provider = "copilot";
        };
        telemetry = {
          metrics = false;
        };
      };
    };

    git = {
      enable = true;
      settings.user = {
        name = gitconfig.user.name;
        email = gitconfig.user.email;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    nh = {
      enable = true;
      homeFlake = "$HOME/.config/home-manager";
      clean.enable = true;
    };

    btop.enable = true;
    bat.enable = true;
    lazygit.enable = true;
  };
}
