pkgs:

{
    enable = true;
    userName  = "Ian Kenney";
    userEmail = "ian.kenney@louder.com.au";
    aliases = {
      a = "add";
      c = "commit";
      d = "difftool -y";
      m = "mergetool -y";
      pub = "push";
      s = "status";
      st = "status";
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
      diff = {
        tool = "nvimdiff";
        conflictstyle = "diff3";
      };
      merge = {
        tool = "nvimdiff";
        conflictstyle = "diff3";
      };
    };
}
