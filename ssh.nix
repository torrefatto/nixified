{ lib, ...}:
{
  programs.ssh = {
    matchBlocks = {
      # Sane settings
      "*" = {
        controlMaster = lib.mkForce "auto";
        controlPersist = lib.mkForce "1800";
        controlPath = lib.mkForce "~/.ssh/sockets/%C";
        identityAgent = "/Users/leonardo.barcaroli/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
        setEnv = {
          TERM = "xterm";
        };
      };
    };
  };
}
