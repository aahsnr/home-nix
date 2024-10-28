{ config, pkgs, ... }:

let
   org-block-capf = import
    ( pkgs.fetchFromGitHub
      {
        owner = "xenodium";
        repo = "org-block-capf";
        rev = "main";
        sha256 = "sha256-iQPuKkIrAfpFf6G9E1kCOOCoB2riSuuRrtpfeBe20uc=";
      }
    );

in {
  home.packages = [org-block-capf];
}
