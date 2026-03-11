{
  #imports = [];
  programs.git = {
    enable = true;

    signing = {
      format = "openpgp";
      key = "0x1A06ACF18DCB695D3808EF82D8DBFB6A2AC6610C";
    };

    settings = { 
    };
  };
}
