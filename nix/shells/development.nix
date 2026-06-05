let
  overrides = builtins.fromTOML (builtins.readFile ../../rust-toolchain.toml);
in
{
  perSystem =
    { pkgs, ... }:
    let 
      formatters = builtins.attrValues config.treefmt.build.programs;
      hooks = config.pre-commit.settings.enabledPackages;
      tooling = with pkgs; [
        rust-analyzer
        cargo
        rustc
        gcc
      ];
    in
    {
      devShells.development = pkgs.mkShell {
        inherit (config.pre-commit) shellHook;
        packages = tooling ++ hooks ++ formatters;
        env = {
          RUSTC_VERSION = overrides.toolchain.channel;
          RUST_BACKTRACE = "full";
        };
      };
    };
}
