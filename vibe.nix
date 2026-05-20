{
  programs.mistral-vibe.settings = {
    enable_notifications = true;

    mcp_servers = [
      {name="notion"; transport="http"; url = "https://mcp.notion.com/mcp";}
    ];
  };
}
