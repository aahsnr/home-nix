{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Macchiato";
      italic-text = "always";
      paging = "never";
      pager="less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
      map-syntax = [
        "*.ino:C++"
        ".ignore:Git Ignore"
      ];
    };
    extraPackages = with pkgs.bat-extras; [
        batdiff batman batgrep batwatch 
    ];

    syntaxes = {
      gleam = {
        src = pkgs.fetchFromGitHub {
          owner = "molnarmark";
          repo = "sublime-gleam";
          rev = "2e761cdb1a87539d827987f997a20a35efd68aa9";
          hash = "sha256-Zj2DKTcO1t9g18qsNKtpHKElbRSc9nBRE2QBzRn9+qs=";
        };
        file = "syntax/gleam.sublime-syntax";
      };
    };
  };
}
