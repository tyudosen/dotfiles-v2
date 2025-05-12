{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "x86_64-darwin";

  users.users.toyo = {
    name = "toyo";
    home = "/Users/toyo";
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.stateVersion = 6;
  system.configurationRevision = null;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Ataraxia";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };
}

