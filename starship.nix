{ lib, ...}:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
	error_symbol = "[⨯](bold red)";
      };

      format = lib.concatStrings [
        "[](fg:202)$os$username"
	"[](bg:11 fg:202)$directory"
	"[](fg:11 bg:14)\${custom.jj}"
	"[](fg:14 bg:12)$c$cpp$rust$golang$nodejs$python"
	"[](fg:12 bg:8)$docker_context"
	"[](fg:8 bg:234)$time"
	"[](fg:202)$line_break$character"
      ];

      os = {
        disabled = false;
	style = "bg:202 fg:230";
      };

      username = {
        disabled = false;
	show_always = true;
	style_user = "bg:202 fg:230";
	style_root = "bg:202 fg:9";
	format = "[blallo]($style)";
      };

      directory = {
        style = "fg:230 bg:11"; 
	format = "[$path]($style)";
	truncation_length = 3;
	truncation_symbol = "…/";
      };

      git_branch = {
        disabled = true;
        style = "bg:14";
	format = "[[ $symbol $branch ](fg:230 bg:14)]($style)";
      };

      git_status = {
        disabled = true;
        style = "bg:14";
	format = "[[ $all_status$ahead_behind ](fg:230 bg:14)]($style)";
      };

      custom.jj = {
        when = "jj-starship detect";
	shell = ["jj-starship" "--no-color"];
	style = "bg:14";
        format = "[[ $output](fg:230 bg:14)]($style)";
      };

      c = {
        disabled = false;
	style = "bg:12";
	format = "[[ $symbol ($version)](fg:230 bg:12) ]($style)";
      };

      cpp = {
        disabled = false;
	style = "bg:12";
	format = "[[ $symbol ($version)](fg:230 bg:12) ]($style)";
      };

      rust = {
        disabled = false;
	style = "bg:12";
	format = "[[ $symbol ($version)](fg:230 bg:12) ]($style)";
      };

      golang = {
        disabled = false;
	style = "bg:12";
	format = "[[ $symbol ($version)](fg:230 bg:12) ]($style)";
      };

      nodejs = {
        disabled = false;
	style = "bg:12";
	format = "[[ $symbol ($version)](fg:230 bg:12) ]($style)";
      };

      python = {
        disabled = false;
	style = "bg:12";
	format = "[[ $symbol ($version)](fg:230 bg:12) ]($style)";
      };


      time = {
        disabled = false;
	time_format = "%R";
	style = "bg:8";
	format = "[[ 🕑 $time ](fg:230 bg:202)]($style)";
      };

    };
  };
}
