{ lib, pkgs, inputs, ... }:
{
  # Use the vibe package built from the local flake checkout.
  programs.mistral-vibe.package =
    inputs.mistral-vibe.packages.${pkgs.stdenv.hostPlatform.system}.default;

  programs.mistral-vibe.settings = {
    enable_notifications = true;
    voice_mode_enabled = true;

    #active_model = lib.mkForce "mistral-large-4";
    #active_model = "opus-4.8";
    #active_model =  lib.mkForce "glm-5.3";
    active_model = lib.mkForce "sol";

    vim_keybindings = true;

    connectors = [
      {name = "notion"; disabled = false;}
      {name = "linear"; disabled = false;}
    ];

    skill_paths = [
      "~/.claude/skills"
      "~/workspace/personal/skills/skills"
    ];
  };
}
