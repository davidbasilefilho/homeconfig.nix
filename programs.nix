{ config, pkgs, ... }:

let
  gitconfig = builtins.fromTOML (
    builtins.readFile "${config.xdg.configHome}/home-manager/gitconfig.toml"
  );
in
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
    nerd-fonts.geist-mono
    nixfmt
    adwaita-fonts
    neovim
    fzf
    gnumake
    fastfetch
    pipes-rs
    pfetch-rs
    ramfetch
    gcc
    cmatrix
    unimatrix
    fd
    ripgrep
  ];

  home.shell = {
    enableBashIntegration = true;
  };

  home.shellAliases = {
    ls = "eza -lah";
    gc = "git add . && git commit -m";
    n = "nvim";
    upsys = "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y; flatpak update && flatpak uninstall --unused -y; nh home switch --impure";
    nixup = "nh home switch --impure";
    aptup = "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y";
    flatpakup = "flatpak update && flatpak uninstall --unused -y";
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
