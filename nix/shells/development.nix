let 
  overrides = (builtins.fromTOML (builtins.readFile ../../rust-toolchain.toml));
in
{
  perSystem = { pkgs, ... }: {
    devShells.development = pkgs.mkShell {
      
      env = {
        RUSTC_VERSION = overrides.toolchain.channel;
        RUST_BACKTRACE = "full";
      };

      packages = with pkgs; [
        rust-analyzer
        cargo
        rustc
        gcc
      ];
    };
  };
}
