{ lib, ...}:
{
  programs.ssh = {
    matchBlocks = {
      # Sane settings
      "*" = {
        controlMaster = lib.mkForce "yes";
        controlPersist = lib.mkForce "yes";
        identityAgent = "/Users/leonardo.barcaroli/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      };
    };
  };
}
