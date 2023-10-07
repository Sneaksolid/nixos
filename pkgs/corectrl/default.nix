{ stdenv
, qtbase
, qtcharts
, qttools
, quazip
, botan2
, wrapQtAppsHook
, gcc
, cmake
, pkg-config
, dbus
, polkit
}:

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
  ];

  nativeBuildInputs = [
    gcc
    cmake
    pkg-config
    wrapQtAppsHook
    polkit
    dbus
  ];

  buildPhase = "make -j $NIX_BUILD_CORES";

  cmakeFlags = [
    "-DINSTALL_DBUS_FILES_IN_PREFIX=ON"
  ];

  PKG_CONFIG_POLKIT_GOBJECT_1_POLICYDIR = "${placeholder "out"}/share/polkit-1/actions";
}
