{ stdenv, fetchFromGitHub }: 

stdenv.mkDerivation {
  pname = "sddm-chili";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "MarianArlt";
    repo = "kde-plasma-chili";
    rev = "v0.5.0";
    sha256 = "sha256-lH7CwKNYhpiNbQglCadnDtnnU/CW1H5h5Bimdv0CV5o=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/chili
    cp -R ./* $out/share/sddm/themes/chili
  '';
}
