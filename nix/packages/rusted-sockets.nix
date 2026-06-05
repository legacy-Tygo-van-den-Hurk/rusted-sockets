let 
  src = ../..;
  cargo = builtins.fromTOML (builtins.readFile (src + "/Cargo.toml"));
  overrides = (builtins.fromTOML (builtins.readFile (src + "/rust-toolchain.toml")));
in
{
  perSystem = {pkgs, ... }: {
    packages.rusted-sockets = pkgs.rustPlatform.buildRustPackage {
      inherit (cargo.package) name;
      inherit (cargo.package) version;
      
      inherit src;
      cargoLock.lockFile = src + "/Cargo.lock";
      
      env = {
        RUSTC_VERSION = overrides.toolchain.channel;
        RUST_BACKTRACE = "full";
      };

      nativeBuildInputs = with pkgs; [ pkg-config ];

      postUnpack = ''
        ls "$src"
      '';
    };
  };
}
