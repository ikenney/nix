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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.autojump.enable = true;

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

  programs.ruff = {
    enable = true;
    settings = {
      line-length = 88;
      select = ["ALL"];
      ignore = [
          "A003"    # Allow shadowing builtins (e.g. `id`, `list`) on classes
          "ANN101"  # Don't annotate `self` on instance methods
          "ANN102"  # Don't annotate `cls` on class methods
          "ANN401"  # Allow annotating with `Any` (e.g. `def foo(**kwargs: Any):...`)
          "B008"    # Allow for function calls in function arguments (good for typer)
          "D203"    # Require no blank lines before class docstring
          "D212"    # Require starting multi-line docstring on a new line
          "D416"    # Doesn't force : at the end of docstring sections
          "DTZ003"  # Allow use of `datetime.utcnow()`
          "EM101"   # Allow raw string literals as exception messages
          "EM102"   # Allow f-strings as exception messages
          "FA102"   # Don't require __future__ annotations
          "FIX002"  # Allow for `TODO` in comments
          "G004"    # Allow f-strings in logging methods
          "ISC003"  # Allow explicit string concatenation
          "S113"    # Allow requests without a timeout
          "TID252"  # Allow for relative imports
          "TRY003"  # Allow specifying messages inside the exception class
          "TRY401"  # Allow for logging exception messages
          "PLR0913" # Allows for more than 5 args to a function
      ];
      exclude = [
          "venv"
          "dist"
          ".git"
      ];
      per-file-ignores = {
        "__init__.py" = [
          "D104"     # Allow for empty __init__.py files
        ];
        "*/tests/*" = [
            "S101"   # Allow asserts in tests
            "SLF001" # Allow access private member functions in tests
        ];
      };
    };
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
