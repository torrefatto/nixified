{ lib, ...}:
{
  programs.ssh.settings = {
      "*" = {
        ControlMaster = lib.mkForce "auto";
        ControlPersist = lib.mkForce "1800";
        ControlPath = lib.mkForce "~/.ssh/sockets/%C";
        #IdentityAgent = "/Users/leonardo.barcaroli/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
        IdentityAgent = "/Users/leonardo.barcaroli/.gnupg/S.gpg-agent.ssh";
        SetEnv.TERM = "xterm";
      };

      "github.com" = {
        ControlMaster = lib.mkForce "auto";
        ControlPersist = lib.mkForce "1800";
        ControlPath = lib.mkForce "~/.ssh/sockets/github";
        IdentityAgent = "/Users/leonardo.barcaroli/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
        IdentitiesOnly = true;
        IdentityFile = "/Users/leonardo.barcaroli/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys/7726bfd8aab131cd6e1fcecf3d915645.pub";
        #IdentityAgent = "/Users/leonardo.barcaroli/.gnupg/S.gpg-agent.ssh";
        SetEnv.TERM = "xterm";
      };
    };
}
