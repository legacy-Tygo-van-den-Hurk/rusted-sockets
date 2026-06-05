{
  imports = [ ./rusted-sockets.nix ];
  perSystem =
    { self', ... }:
    {
      packages.default = self'.packages.rusted-sockets;
    };
}
