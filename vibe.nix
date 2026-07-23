{ lib, ... }:
{
  # Use the vibe package built from the local flake checkout.
  programs.mistral-vibe.package =
    inputs.mistral-vibe.packages.${pkgs.stdenv.hostPlatform.system}.default;

  programs.mistral-vibe.settings = {
    enable_notifications = true;
    voice_mode_enabled = true;

    #active_model = lib.mkForce "mistral-large-4";
    active_model = "opus-4.8";

    mcp_servers = [
      {name="notion"; transport="http"; url = "https://mcp.notion.com/mcp"; disabled = false;}
      {name="linear"; transport="http"; url = "https://mcp.linear.app/mcp"; disabled = false;}
    ];

    connectors = [
      {name = "notion"; disabled = false;}
      {name = "linear"; disabled = false;}
    ];
  };
}
