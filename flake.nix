{
  description = "Source-only MoonBit library: totto2727/any-collection";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    moonbit-overlay = {
      url = "github:totto2727/moonbit-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    moon-registry = {
      url = "git+https://mooncakes.io/git/index";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, moonbit-overlay, moon-registry }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      forEachSystem = nixpkgs.lib.genAttrs supportedSystems;
      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [ moonbit-overlay.overlays.default ];
      };
      mkMoonHome = pkgs:
        pkgs.moonPlatform.bundleWithRegistry {
          cachedRegistry = pkgs.moonPlatform.buildCachedRegistry {
            moonModDepsSet = { "Yoorkin/any" = "0.2.1"; };
            registryIndexSrc = moon-registry;
          };
        };
      mkMoonCheck = pkgs: name: command:
        let
          moonHome = mkMoonHome pkgs;
        in
        pkgs.runCommand name {
          nativeBuildInputs = [ moonHome pkgs.nodejs pkgs.stdenv.cc ];
        } ''
          export HOME="$TMPDIR/home"
          mkdir -p "$HOME" "$TMPDIR/repository"
          cp -r ${self}/. "$TMPDIR/repository"
          chmod -R u+w "$TMPDIR/repository"
          cd "$TMPDIR/repository"
          ${command}
          touch "$out"
        '';
    in
    {
      devShells = forEachSystem (system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = [ (mkMoonHome pkgs) ];
          };
        });

      checks = forEachSystem (system:
        let
          pkgs = mkPkgs system;
        in
        {
          moon = mkMoonCheck pkgs "any-collection-moon-check" ''
            moon info
            moon check --target all
            moon test --target all
          '';
          package-list = mkMoonCheck pkgs "any-collection-package-list" ''
            moon package --list
          '';
        });
    };
}
