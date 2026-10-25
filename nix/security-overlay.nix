# Temporary CVE-2026-111497 backports; remove after the pinned nixpkgs has them.
final: prev:
let
  bunVersion = "1.4.4";
  # SHA-256 digests from the upstream bun-v1.4.4 GitHub release assets.
  bunAssets = {
    aarch64-darwin = {
      name = "bun-darwin-aarch64";
      sha256 = "c240d7f0ccb90c263a849fcdb09b7ee62630d921348ed6aafda86b9d577bc510";
    };
    aarch64-linux = {
      name = "bun-linux-aarch64";
      sha256 = "baa6bb36f51d6e58561e02bbea825038a9df454f673d6d776e8bbf86f8c7850e";
    };
    x86_64-darwin = {
      name = "bun-darwin-x64-baseline";
      sha256 = "d4a155adfbfd09155eb3ba05c9e3a544f39297d7a68616d3c7759f67ab5c47dc";
    };
    x86_64-linux = {
      name = "bun-linux-x64";
      sha256 = "bf8ccbfb2b0b80159e0f9a6d15c55317add8077534dbc6130a3edb52fccb395c";
    };
  };
  bunSources = prev.lib.mapAttrs (_: asset: prev.fetchurl {
    url = "https://github.com/oven-sh/bun/releases/download/bun-v${bunVersion}/${asset.name}.zip";
    inherit (asset) sha256;
  }) bunAssets;
in
{
  # Node in this nixpkgs uses --shared-brotli. Updating Node's bundled copy
  # alone does not fix its runtime; patch the shared library for all consumers.
  brotli = prev.brotli.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./patches/brotli-CVE-2026-111497.patch ];
  });

  nodejs-slim_22 = prev.nodejs-slim_22.overrideAttrs (finalAttrs: old: {
    version = "22.23.4";
    src = prev.fetchurl {
      url = "https://nodejs.org/dist/v22.23.4/node-v22.23.4.tar.xz";
      sha256 = "7b9adc82d612d0a2a863d96c46de2292552e250cee51956ebbe0146c42aacae9";
    };
    passthru = (old.passthru or { }) // {
      tests = (old.passthru.tests or { }) // {
        version = prev.testers.testVersion {
          package = finalAttrs.finalPackage;
          version = "v22.23.4";
        };
      };
    };
  });

  bun = prev.bun.overrideAttrs (old: {
    version = bunVersion;
    src = bunSources.${prev.stdenv.hostPlatform.system};
    passthru = (old.passthru or { }) // { sources = bunSources; };
  });
}
