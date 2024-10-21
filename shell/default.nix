{ pkgs, lib, config, ... }:
{
   imports = [
     ./xdg.nix
     ./zsh.nix
     ./starship.nix
     ./cli.nix
     ./nix.nix
   ];
}
