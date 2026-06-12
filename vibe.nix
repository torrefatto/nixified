{
  programs.mistral-vibe.settings = {
    enable_notifications = true;

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
