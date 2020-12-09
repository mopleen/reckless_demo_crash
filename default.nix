let
  pkgs = let
    src = import nix/sources.nix;
    reckless_derivation = { stdenv, cmake, fetchFromGitHub }:
      let version = "v3.0.2";
      in stdenv.mkDerivation {
        pname = "reckless";
        inherit version;
        src = fetchFromGitHub {
          owner = "mattiasflodin";
          repo = "reckless";
          rev = version;
          sha256 = "1y6aw15dk95fhgqsw83dlaqqr7r8q4jy68qkjvzk1li6ivgzsgb7";
        };

        dontStrip = true;

        hardeningDisable = [ "all" ];

        installPhase = ''
          mkdir -p $out/lib
          cp libreckless.a $out/lib/
          cp -r $src/reckless/include $out/
        '';

        nativeBuildInputs = [ cmake ];
      };
    add_reckless = self: super: {
      reckless = super.callPackage reckless_derivation { };
    };
  in import src.nixpkgs { overlays = [ add_reckless ]; };
in pkgs.stdenv.mkDerivation {
  pname = "demo_crash";
  version = "0.0";

  dontStrip = true;

  nativeBuildInputs = [ pkgs.cmake ];

  buildInputs = [ pkgs.reckless ];

  src = ./src;

  NIX_CFLAGS_COMPILE = "-g1 -fsanitize=address";
}
