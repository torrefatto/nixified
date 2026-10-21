{ pkgs, ... }:
{
    programs.taskwarrior = {
        enable = true;
        package = pkgs.taskwarrior3;
        config = {
            confirmation = true;
        };
    };
}
