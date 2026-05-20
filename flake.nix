{
  description = "Nixtral configuration";

  #inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";

  #inputs.nixtral.url = "git+ssh://git@github.com/mistralai/nixtral.git?ref=<branch>";
  inputs.nixtral.url = "git+ssh://git@github.com/mistralai/nixtral.git";
  #inputs.nixtral.inputs.nixpkgs.follows = "nixpkgs";

  inputs.jj-starship.url = "github:dmmulroy/jj-starship";

  outputs =
    { self, nixtral, ... }:
    let
      profileName = "default";
    in
    {
      homeConfigurations.${profileName} = nixtral.lib.mkHomeManagerConfiguration {
        modules = [
          ./config.nix
          { nixtral.configProfile = profileName; }
          ./ssh.nix
          ./bash.nix
          ./zsh.nix
          ./starship.nix
          ./zellij.nix
          ./atuin.nix
          ./gnupg.nix
          ./git.nix
          ./jj.nix
          ./vibe.nix
        ];
      };

      checks.aarch64-darwin.home-manager = self.homeConfigurations.${profileName}.activationPackage;
    };
}
