{
  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "Leonardo Barcaroli";
        email = "leonardo.barcaroli@mistral.ai";
      };

      ui = {
        merge-editor = "vimdiff";
        bookmark-list-sort-keys = ["commiter-date-"];
        default-command = "status";
      };

      merge-tools = {
        delta = {
          diff-expected-exit-codes = [0 1];
          diff-args = ["--side-by-side" "$left" "$right" "--width=$width"];
        };

        vimdiff.diff-invocation-mode = "file-by-file";
      };

      signing = {
        behavior = "own";
        backend = "gpg";
      };

      revsets = {
        bookmark-advance-to = "heads(::@ & mutable() & ~description(exact:\"\") & (~empty() | merges()))";
      };

      aliases = {
        pull = ["util" "exec" "--" "bash" "-c" ''
        jj git fetch
        jj new -A $1@origin
        jj bookmark set local --allow-backwards
        jj rebase -r local --destination=$1@origin
        '' ""];
        push = ["util" "exec" "--" "bash" "-c" ''
        jj bookmark track $1 --remote=origin
        jj git push -b $1
        '' "jj-push"];
        llog = ["log" "-r" "(local..@):: | (local..@)-"];
        rlog = ["log" "-r" "($1@origin..@):: | ($1@origin..@)-"];
      };
    };
  };

  programs.delta.enableJujutsuIntegration = true;
}
