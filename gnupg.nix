{ lib, ... }:
{
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
  };

  services.gpg-agent = {
    enable = true;
    enableScDaemon = true;
    enableZshIntegration = true;
    enableSshSupport = true;
  };
}
