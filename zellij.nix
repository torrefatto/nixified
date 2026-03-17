{
  programs.zellij = {
    enable = true;
    #enableZshIntegration = true;
    extraConfig = ''
      keybinds {
        unbind "Alt f"
      }
    '';
  };
}
