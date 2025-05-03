{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.aarch64-linux;
    in
    {

      packages.aarch64-linux.tree = nixpkgs.legacyPackages.aarch64-linux.tree;

      defaultPackage.aarch64-linux = self.packages.aarch64-linux.tree;

      hydraJobs."tester2" = self.defaultPackage;
      hydraJobs."tester" = self.defaultPackage;
      hydraJobs."tester-readme" = pkgs.runCommand "readme" { } ''
        echo hello worl
        mkdir -p $out/nix-support
        echo "# A readme" > $out/readme.md
        echo "doc readme $out/readme.md" >> $out/nix-support/hydra-build-products
      '';
    };
}

