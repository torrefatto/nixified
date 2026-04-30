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

        codex = {
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
    viddy
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
    podman-compose
    kind
    gh
    # languages and toolchains
    go
    delve
    golangci-lint
    buf
    ko
    rustup
    python3
    gnumake
    nil
    uv
    nodejs_25
    pnpm
    jsonnet
    # kubernetes & cloud
    kubectl
    k9s
    kubectx
    kubernetes-helm
    gcloud
    google-cloud-sql-proxy
    pgcli
    terraform
  ];

  home.sessionPath = [
    "/Users/leonardo.barcaroli/.bin"
    "/opt/homebrew/bin"
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SDKROOT = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk";
    MANPAGER = "bat -l man -p";
    TF_VAR_org_id = "226702439374";
    TF_ADMIN = "koyeb-terraform-admin";
    TF_VAR_billing_account = "0163CA-A0F034-8C198B";
    TF_CREDS = "$HOME/.koyeb-infra/gcp-credentials.json";
    GOOGLE_APPLICATION_CREDENTIALS = "$HOME/.koyeb-infra/gcp-credentials.json";
    GOOGLE_PROJECT = "koyeb-terraform-admin";
    CLOUDFLARE_ZONE_ID = "5e3d2af4149d478110cec915409094bf";
    CLOUDFLARE_ACCOUNT_ID = "8f3ae507b764dc038d563adaf6f500cf";
  };

  # manual management of the original vim config (keeping vim and neovim distinct)
  programs.neovim.vimAlias = lib.mkForce false;
}
