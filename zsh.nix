{ lib, ... }
:{
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-syntax-highlighting"
      ];
    };

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -la";
      l = "ls -1";
      lrt = "ls -lrt";
      k = "kubectl";
      t = "tmux";
      z = "zellij";
      jjj = "jj-fzf";
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
      kkk = "cbonsai -m 'You should rest'";
    };

    setOptions = [
       "NO_COMPLETE_ALIASES"
    ];

    profileExtra = ''
    eval "$(brew shellenv)"
    '';

    initContent = let
      zshFunctions = lib.mkOrder 500 ''
        # Functions

        function ,cd () {
            [ "z''${_ZROOT}" != "z" ] && cd "''${_ZROOT}" && return 0
            [ "z''${TMUX_BASE}" != "z" ] && cd "''${TMUX_BASE}" && return 0
            cd ~
        }

        function __regen_or_source() {
            local source="''${HOME}/.config/zsh_completions/''${1}"
            local source_command="''${2}"

            if [ ! -f ''${source} ] || find ''${source} -type f -mtime +1 | grep -q .; then
                zsh -c "''${source_command}" > ''${source}
            fi

            . ''${source}
        }
      '';
      zshCompletions = lib.mkOrder 1000 ''
        # Completions and bindings

        __regen_or_source _tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale completion zsh"

        # Completion paths

        fpath+=("''${HOME}/.config/zsh_completions")

        # Binds

        bindkey -e
      '';

      zshZellijEnv = lib.mkOrder 1500 ''
        # If in zellij, always source env in a special direrctory
        ZSTATEPATH=''${ZSTATEPATH:-''${HOME}/.local/share/zsession}

        if [ "z''${ZELLIJ_SESSION_NAME}" != "z" ]; then
            ZSTATEFILE="''${ZSTATEPATH}/''${ZELLIJ_SESSION_NAME}"
            [ -f ''${ZSTATEFILE} ] && source ''${ZSTATEFILE}
        fi
      '';
    in
        lib.mkMerge [
            zshFunctions
            zshCompletions
            zshZellijEnv
        ];
  };
}
