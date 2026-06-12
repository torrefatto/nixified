{
  lib,
  buildGoModule,
  fetchFromGitHub,
  apple-sdk,
}:

buildGoModule rec {
  pname = "pinentry-touchid";
  version = "0.0.4";

  src = fetchFromGitHub {
    owner = "lujstn";
    repo = "pinentry-touchid";
    rev = "v${version}";
    hash = "sha256-2+AuUbyA1CZQROjX/Wlcx+OVsvOQgli5oPjAEdKB1Gk=";
  };

  vendorHash = "sha256-UgdJauwle/9FqglmO1eyVsplq6Bw2GHCYtcGIhdZZ+Q=";

  # Only build the main package; the ./go-assuan replace dir contains
  # subpackages that aren't part of this module's import path.
  subPackages = [ "." ];

  # New darwin SDK pattern (nixpkgs 24.11+): the SDK exposes all frameworks
  # (CoreFoundation, Foundation, LocalAuthentication, ...) automatically.
  buildInputs = [ apple-sdk ];

  # Link the CoreFoundation framework explicitly (kept from upstream shell.nix).
  preBuild = ''
    export NIX_LDFLAGS="-framework CoreFoundation -framework LocalAuthentication $NIX_LDFLAGS"
  '';

  # Tests require Touch ID hardware / keychain access.
  doCheck = false;

  meta = {
    description = "Custom GPG pinentry program for macOS using Touch ID (lujstn fork, GnuPG 2.4+ compatible)";
    homepage = "https://github.com/lujstn/pinentry-touchid";
    license = lib.licenses.asl20;
    platforms = lib.platforms.darwin;
    mainProgram = "pinentry-touchid";
  };
}
