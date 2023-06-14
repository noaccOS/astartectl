{ go
, gopls
, goreleaser
, mkShell
, lib
, withLSP ? true
, withReleaser ? false
}:
mkShell {
  packages = [ go ]
    ++ lib.optional withLSP gopls
    ++ lib.optional withReleaser goreleaser;
}
