{
  programs.zellij = {
    enable = true;
    #enableZshIntegration = true;
    extraConfig = ''
      keybinds {
        unbind "Alt f"
        normal clear-defaults=true {
            bind "Ctrl k" { SwitchToMode "locked"; }
            bind "Ctrl b" { SwitchToMode "tmux"; }
        }
        locked {
            bind "Ctrl k" { SwitchToMode "Normal"; }
        }
      }
    '';
  };
}
