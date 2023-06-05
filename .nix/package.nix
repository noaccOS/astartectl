{ buildGoModule, installShellFiles, stdenv, lib }:
buildGoModule rec {
  pname = "astartectl";
  version = "23.5.0-dev";
  src = ../.;

  nativeBuildInputs = [ installShellFiles ];
  vendorSha256 = "sha256-2cbFgvzncJFLwtMvpHePB7E8l9Emp9lFn4cHBAnW0Bo=";

  postInstall = lib.optionalString (stdenv.hostPlatform == stdenv.buildPlatform) ''
    installShellCompletion --cmd astartectl \
      --bash <($out/bin/astartectl completion bash) \
      --fish <($out/bin/astartectl completion fish) \
      --zsh <($out/bin/astartectl completion zsh)
  '';
}
