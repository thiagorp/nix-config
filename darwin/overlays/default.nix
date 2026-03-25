[
  (import ./netcdf.nix)
  (final: prev: {
    mdbook-linkcheck = prev.mdbook-linkcheck2;
  })
]
