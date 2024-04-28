pkgs:

{
  enable = true;
  vimAlias = true;
  viAlias = true;

  extraConfig = ''
    luafile ~/.config/home-manager/nvim/settings.lua
  '';

  plugins = with pkgs.vimPlugins; [
    nvim-web-devicons
    nvim-tree-lua

    # syntax / lsp
    nvim-treesitter   
    nvim-lspconfig
    # mason-lspconfig-nvim
    nvim-cmp

    # comments
    comment-nvim

    # status line
    lualine-nvim

    # theme
    palenight-vim

    # terminal
    toggleterm-nvim
  ];
}
