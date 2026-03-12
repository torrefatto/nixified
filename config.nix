/*
  This is a home-manager configuration.

  Resources:
  - Manual: https://nix-community.github.io/home-manager/
  - GitHub repo: https://github.com/nix-community/home-manager
  - Available options: https://nix-community.github.io/home-manager/options.xhtml
*/
{ lib, pkgs, ... }:
let
  gcloud = pkgs.google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in
{
  # Options under `nixtral` are custom and definied in https://github.com/mistralai/nixtral
  # Check out the README to see what options are available
  nixtral = {
    # TODO
    username = "leonardo.barcaroli";

    clusters = {
      enable = false;

      ssh.enable = false;

      # TODO
      username = "leonardo.barcaroli";

      # TODO: find yours with `sacctmgr list accounts`
      slurmAccount = "your-slurm-account";

      # TODO: check that tilde works
      mistralRoot = "~/workspace/mistral";
    };
  };

  # Install some packages
  # Find available packages here: https://search.nixos.org/packages?channel=unstable
  home.packages = with pkgs; [
    # crypto
    gnupg
    sequoia-sq
    sequoia-sqv
    # shell
    bash # macos builtin bash is ancient
    zsh
    starship
    jj-starship
    zellij
    atuin
    bat
    # mgmt
    htop
    kubectl
    # dev tools
    jq
    git
    tig
    jujutsu
    jj-fzf
    delta
    podman
    # languages and toolchains
    go
    rustup
    python3
    gnumake
    nil
    # kubernetes & cloud
    kubectl
    k9s
    kubectx
    gcloud
  ];

  home.sessionPath = [
    "/Users/leonardo.barcaroli/.bin"
    "/opt/homebrew/bin"
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # manual management of the original vim config (keeping vim and neovim distinct)
  programs.neovim.vimAlias = lib.mkForce false;
}
