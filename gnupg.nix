{ lib, pkgs, ... }:
let
  passphraseCacheTtl = 8 * 60 * 60;
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
    defaultCacheTtl = passphraseCacheTtl;
    maxCacheTtl = passphraseCacheTtl;
    enableScDaemon = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    pinentry.package = pinentry-touchid;
    sshKeys = [
      "3BC138C5586B157F2B53ECDEFC71C47531740F95"
    ];
  };
}
