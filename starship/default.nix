{ pkgs, }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      conda.symbol = |" ";
      python.symbol = " ";
      add_newline = false;
      line_break.disabled = true;
      format = lib.concatStrings [
        "$line_break"
        "$package"
        "$line_break"
        "$character"
      ];
      character = {
        success_symbol = "[ ](bold blue)";
        error_symbol = "[ ](bold red)";
        vicmd_symbol = "[](bold yellow)";
      };
      directory = {
        format = " [$path](blue)";
        truncation_length = 3;
        truncate_to_repo=false;
        disabled = false;
      };
      git_branch = {
        format = "[󰘬 ](yellow)[$branch](yellow) ";
      };
      git_status = {
        format= "[ 󰊤 ](green)[$all_status$ahead_behind](green) ";
        conflicted = "=";
        ahead =	" 󰄿 ${count}";
        behind = " 󰄼 ${count}";
        diverged = " 󰄿 ${ahead_count} 󰄼 ${behind_count}";
        up_to_date = " 󰄬";
        untracked = "?${count}";
        stashed = "󰏖";
        modified = "!${count}";
        staged = "+${count}";
        renamed = "*${count}";
        deleted = "-${count}";
      };
    };
  };
}
