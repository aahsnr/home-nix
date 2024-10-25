{ config, pkgs, lib, inputs, ... }:

{
  home.packages = [pkgs.git];
  nix = {
    gc = {
      automatic = true;
      frequency = "daily";
      options = "--delete-older-than 3d";
    };
    package = pkgs.nixVersions.latest;
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;
    settings = {
      flake-registry = "/etc/nix/registry.json";
      builders-use-substitutes = false;
      allowed-users = ["@wheel" "ahsan"];
      trusted-users = ["@wheel" "ahsan"];
      max-jobs = "auto";
      keep-going = true;
      # substituters = [
      #   "https://cache.nixos.org"
      #   "https://nix-community.cachix.org"
      #   "https://nixpkgs-unfree.cachix.org"
      #   "https://hyprland.cachix.org"
      #   "https://hyprland-community.cachix.org"
      #   "https://cuda-maintainers.cachix.org"
      #   "https://anyrun.cachix.org"
      # ];
      # trusted-public-keys = [
      #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      #   "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      #   "hyprland-community.cachix.org-1:5dTHY+TjAJjnQs23X+vwMQG4va7j+zmvkTKoYuSXnmE="
      #   "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      # ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };
}
