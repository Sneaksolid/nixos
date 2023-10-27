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

    kube_config_prd = {
      format = "binary";
      sopsFile = "${self}/secrets/kube_config_prd";
      path = "${homeDirectory}/.kube/config_prd";
    };

    kube_config_stg = {
      format = "binary";
      sopsFile = "${self}/secrets/kube_config_stg";
      path = "${homeDirectory}/.kube/config_stg";
    };

    kube_config_uat = {
      format = "binary";
      sopsFile = "${self}/secrets/kube_config_uat";
      path = "${homeDirectory}/.kube/config_uat";
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

    kube_switch_prd = {
      source = "${self}/scripts/switch_to_prd.sh";
      target = "${homeDirectory}/.kube/switch_to_prd.sh";
    };

    kube_switch_stg = {
      source = "${self}/scripts/switch_to_stg.sh";
      target = "${homeDirectory}/.kube/switch_to_stg.sh";
    };

    kube_switch_uat = {
      source = "${self}/scripts/switch_to_uat.sh";
      target = "${homeDirectory}/.kube/switch_to_uat.sh";
    };
  };

  home.packages = with pkgs; [
    openfortivpn
    awscli2
    jetbrains.datagrip
    postgresql
    insomnia
    gitkraken

    nodePackages.aws-cdk
    nodePackages.cdk8s-cli

    docker-compose
    docker-buildx

    kubectl
    kubectx
    k3d
    k9s

    netcat-openbsd
    jq
    go-migrate
    python39
    go-task
    go-mockery
    mockgen
    redis
  ];

  programs.zsh = {
    shellAliases = {
      kuat = "source ~/.kube/switch_to_uat.sh";
      kstg = "source ~/.kube/switch_to_stg.sh";
      kprd = "source ~/.kube/switch_to_prd.sh";
      k = "kubectl";
      ks = "k9s";
    };
  };
}
