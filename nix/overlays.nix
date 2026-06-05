{
  inputs,
  ...
}:
with inputs;
{
  flake.overlays = rec {
    default = rusted-sockets;
    rusted-sockets = _final: previous: {
      inherit (self.packages.${previous.stdenv.system}) rusted-sockets;
    };
  };
}
