{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "zeditor";
    TERMINAL = "ghostty";
  };
}
