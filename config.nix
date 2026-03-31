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

    dataHome = "/Users/leonardo.barcaroli/.local/share/nixtral";

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

    vibe = {
      models = {
        anthropic.enable = true;
        mistral.enable = true;
      };

      tools = {
        claude-code = {
          enable = true;
        };

        opencode = {
          enable = true;
        };

        mistral-vibe = {
          enable = true;
        };
      };
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
    fzf
    tree
    cbonsai
    # mgmt
    htop
    kubectl
    bitwarden-cli
    syncthing-macos
    # dev tools
    jq
    fx
    git
    tig
    jujutsu
    jj-fzf
    delta
    podman
    kind
    gh
    # languages and toolchains
    go
    delve
    golangci-lint
    rustup
    python3
    gnumake
    nil
    uv
    nodejs_25
    jsonnet
    # kubernetes & cloud
    kubectl
    k9s
    kubectx
    gcloud
    google-cloud-sql-proxy
    pgcli
  ];

  home.sessionPath = [
    "/Users/leonardo.barcaroli/.bin"
    "/opt/homebrew/bin"
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SDKROOT = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk";
    MANPAGER = "bat -l man -p";
  };

  # manual management of the original vim config (keeping vim and neovim distinct)
  programs.neovim.vimAlias = lib.mkForce false;
}
