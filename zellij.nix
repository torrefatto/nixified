{
  programs.zellij = {
    enable = true;
    #enableZshIntegration = true;
    extraConfig = ''
      keybinds {
        unbind "Alt f"
        normal clear-defaults=true {
            bind "Ctrl g" { SwitchToMode "locked"; }
            bind "Ctrl b" { SwitchToMode "tmux"; }
        }
        locked {
            bind "Ctrl g" { SwitchToMode "Normal"; }
        }
      }
    '';
  };
}
