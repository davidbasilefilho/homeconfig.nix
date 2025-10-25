{ config, pkgs, ... }:

{
  imports = [ ./programs.nix ./env.nix ];
  home.username = "basile";
  home.homeDirectory = "/home/basile";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
