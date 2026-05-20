{ lib, ...}:
{
  programs.ssh.settings = {
      "*" = {
        ControlMaster = lib.mkForce "auto";
        ControlPersist = lib.mkForce "1800";
        ControlPath = lib.mkForce "~/.ssh/sockets/%C";
        IdentityAgent = "/Users/leonardo.barcaroli/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
        SetEnv.TERM = "xterm";
      };
    };
}
