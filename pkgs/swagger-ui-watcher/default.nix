{ lib, mkYarnPackage, fetchFromGitHub }:

mkYarnPackage rec {
  pname = "swagger-ui-watcher";
  version = "2.1.11";

  src = fetchFromGitHub {
    owner = "moon0326";
    repo = pname;
    rev = "master";
    hash = "sha256-JwoT+P4U6rt6zAe2oNyulLTvD8MUjpo4DN5SQ7QfW4E=";
  };
}
