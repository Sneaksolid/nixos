{ stdenv, qtbase, qtcharts, qttools, quazip, botan2, wrapQtAppsHook, gcc, cmake, pkg-config, polkit }:

stdenv.mkDerivation rec {
  pname = "corectrl";
  version = "1.3";

  src = builtins.fetchGit {
    url = "https://gitlab.com/corectrl/corectrl.git";
    ref = "${version}-stable";
    rev = "dd0b8ce1e43c30e014cbaf0590422132acc0ce31";
  };

  buildInputs = [ 
    qtbase
    qtcharts
    qttools
    quazip
    botan2
    polkit
  ];

  nativeBuildInputs = [
    gcc
    cmake
    pkg-config
    wrapQtAppsHook
  ];

  buildPhase = "make";
}
