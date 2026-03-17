{
  programs.zsh = {
    enable = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
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

    initContent = ''
    function ,cd () {
        [ "z''${_ZROOT}" != "z" ] && cd "''${_ZROOT}" && return 0
        [ "z''${TMUX_BASE}" != "z" ] && cd "''${TMUX_BASE}" && return 0
        cd ~
    }

    bindkey -e
    '';
  };
}
