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
        "ohmyzsh/ohmyzsh path:lib/key-bindings.zsh"
        "ohmyzsh/ohmyzsh path:lib/completion.zsh"
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
      docker = "podman";
      pinentry = "pinentry-mac";
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

        function ,pr() {
            local branch="''${1}"
            local title="''${2}"

            if [[ "''${branch}" = "+"* ]]; then
                branch=''${branch#+}
                jj bookmark create -r @- ''${branch}
            fi

            jj push ''${branch}
            gh pr create --title "''${title}" --head ''${branch}
        }

        function ,kssh() {
            local inventory_path=''${ANSIBLE_INVENTORY:-''${HOME}/workspace/koyeb/ansible/inventory}
            local -a ssh_opts
            local -a remote_opts
            local remote_host
            local full_host
            for arg in "''${@}"
            do
                if [[ $arg =~ "@.*" ]]
                then
                    remote_host=''${arg#@}
                else
                    if [ -z $remote_host ]
                    then
                        ssh_opts+=(''${arg})
                    else
                        remote_opts+=(''${arg})
                    fi
                fi
            done
            full_host=$(grep -E "^''${remote_host}" ''${inventory_path}|cut -f1 -d" ")
            if [ "''${full_host}z" = "z" ]
            then
                echo "''${remote_host} not found in ''${inventory_path}"
                return 1
            fi
            echo ssh ''${ssh_opts[@]} -l leonardo "''${full_host}" ''${remote_opts[@]}
            ssh ''${ssh_opts[@]} -l leonardo "''${full_host}" ''${remote_opts[@]}
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
