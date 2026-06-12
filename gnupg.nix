{ lib, pkgs, ... }:
let
  pinentry-touchid = pkgs.callPackage ./pinentry-touchid.nix { };
in
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
    pinentry.package = pinentry-touchid;
  };
}
