{
  description = "Nixtral configuration";


  #inputs.nixtral.url = "git+ssh://git@github.com/mistralai/nixtral.git?ref=blallo/moar-models";
  inputs.nixtral.url = "git+ssh://git@github.com/mistralai/nixtral.git";
  inputs.nixtral.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.jj-starship.url = "github:dmmulroy/jj-starship";

  inputs.bacon-ls.url = "github:crisidev/bacon-ls";
  inputs.bacon-ls.inputs.nixpkgs.follows = "nixpkgs";

  # Local checkout of mistral-vibe; provides the vibe package via its flake.
  inputs.mistral-vibe.url = "git+file:///Users/leonardo.barcaroli/workspace/mistral/mistral-vibe";

  outputs =
    { self, nixtral, bacon-ls, mistral-vibe, ... }:
    let
      profileName = "default";
    in
    {
      homeConfigurations.${profileName} = nixtral.lib.mkHomeManagerConfiguration {
        inputOverrides = { inherit bacon-ls mistral-vibe; };
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
          ./herdr.nix
        ];
      };

      checks.aarch64-darwin.home-manager = self.homeConfigurations.${profileName}.activationPackage;
    };
}
