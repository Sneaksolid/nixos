{ self, pkgs, homeDirectory, ... }:

{
  sops.secrets = {
    aws_credentials = {
      format = "binary";
      sopsFile = "${self}/secrets/aws_credentials";
      path = "${homeDirectory}/.aws/credentials";
    };

    aws_config = {
      format = "binary";
      sopsFile = "${self}/secrets/aws_config";
      path = "${homeDirectory}/.aws/config";
    };

    aws_mka_private = {
      format = "binary";
      sopsFile = "${self}/ssh/aws-mka";
      path = "${homeDirectory}/.ssh/aws-mka";
    };

    id_rsa_private = {
      format = "binary";
      sopsFile = "${self}/ssh/id_rsa";
      path = "${homeDirectory}/.ssh/id_rsa";
    };
  };

  home.file = {
    aws_mka_public = {
      source = "${self}/ssh/aws-mka.pub";
      target = "${homeDirectory}/.ssh/aws-mka.pub";
    };

    id_rsa_public = {
      source = "${self}/ssh/id_rsa.pub";
      target = "${homeDirectory}/.ssh/id_rsa.pub";
    };
  };

  home.packages = with pkgs; [
    awscli2

    nodePackages.aws-cdk
    nodePackages.cdk8s-cli

    docker-compose
    docker-buildx

    kubectl
    kubectx
    k3d

    netcat-openbsd
    jq
    go-migrate
    python39
    go-task
    go-mockery
    mockgen
  ];
}
