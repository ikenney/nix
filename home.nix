{ config, pkgs, ... }:
let 
  username = "iank";
  homedir = "/home/${username}";
  neovimConfig = import ./nvim/nvim.nix;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username; 
  home.homeDirectory = "/home/${username}";
  # home.users.${username}.shell = pkgs.zsh;
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # neovim
  # xdg.configFile."nvim/lua/icons.lua".source = ./nvim/icons.lua;
  programs.neovim = neovimConfig pkgs;


  programs.zsh = {
    enable = true;
    sessionVariables = rec {
      HOME_MANAGER = "${homedir}/.config/home-manager";
      EDITOR = "nvim";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.git = {
    enable = true;
    userName  = "Ian Kenney";
    userEmail = "ian.kenney@louder.com.au";
    extraConfig = {
      core = {
	editor = "nvim";
      };
      init = {
	defaultBranch = "main";
      };
    };
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
