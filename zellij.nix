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
            bind "Ctrl s" { SwitchToMode "entersearch"; SearchInput 0; }
        }
        locked {
            bind "Ctrl k" { SwitchToMode "Normal"; }
        }
        entersearch {
            bind "Ctrl c" "Esc" { ScrollToBottom; SwitchToMode "normal"; }
            bind "Enter" { SwitchToMode "search"; }
        }
        search {
            bind "Ctrl c" "Esc" { ScrollToBottom; SwitchToMode "normal"; }
            bind "n" { Search "down"; }
            bind "p" "Shift n" { Search "up"; }
        }
      }
    '';
  };
}
