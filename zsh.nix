{
  programs.zsh = {
    enable = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
      ];
    };

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      l = "ls -1";
      lrt = "ls -lrt";
      k = "kubectl";
      t = "tmux";
      z = "zellij";
      jjj = "jj-fzf";
    };
  };
}
