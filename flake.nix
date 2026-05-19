{
  description = "estante-cloud — three batteries: k8s (kubectl) / docker / tofu";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: (import "${inputs.substrate}/lib/build/estante/flake.nix" {
    inherit (inputs) nixpkgs flake-utils;
  }) {
    name = "estante-cloud";
    version = "0.1.0";
    src = inputs.self;
    description = "Cloud-native daily-driver shortcuts: kubectl, docker, tofu/terraform.";
    exports = [ "alias" "function" "kind:library"
                "battery:k8s" "battery:docker" "battery:tofu" ];
  };
}
