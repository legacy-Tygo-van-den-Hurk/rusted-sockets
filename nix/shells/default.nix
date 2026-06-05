{
  imports = [ ./development.nix ];
  perSystem = { self', ... }: {
    devShells.default = self'.devShells.development;
  };
}
