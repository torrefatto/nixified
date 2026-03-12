{
  #imports = [];
  programs.git = {
    enable = true;

    signing = {
      format = "openpgp";
      key = "0x1A06ACF18DCB695D3808EF82D8DBFB6A2AC6610C";
    };

    settings = { 
      url = {
        "git@github.com:" = {
	  insteadOf = "https://github.com/";
	};
      };

      core.pager = "delta";

      delta = {
        navigate = true;
	light = false;
	side-by-side = true;
	line-numbers = true;
      };

      diff = {
        colorMoved = "default";
	algorithm = "patience";
      };

      alias = {
        amend = "commit --amend";
        please = "push --force-with-lease";
        recommit = "commit --amend --no-edit";
        rephrase = "commit --amend -m";
        rewrite = "rebase -i --autosquash";
        ffsync = "\"!f(){ git fetch && git reset --hard origin/$(git branch --show-current); }; f\"";
        mergelog = "log --format=\"%C(yellow)%h%Cgreen|%cd| %Creset%s %Cblue(%an)%Creset\" --date=iso8601 --decorate --color=auto --merges --first-parent";
        wip = "commit -m 'wip'";
        fixup = "\"!f(){ git commit --no-sign --fixup=\${1}; git stash; git rebase -i --autosquash \${1}~; git stash pop; }; f\"";
      };
    };
  };
}
