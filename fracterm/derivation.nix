{ stdenv, fetchFromGitHub, gmp, ncurses }:

stdenv.mkDerivation {
  pname = "fracterm";
  version = "0.3";

  src = fetchFromGitHub {
    owner = "dovskyi";
    repo = "fracterm";
    rev = "8e364d4";
    sha256 = "fDxWDrtXHkI/uMqQA9ZCnpluUs96BTt3eg06Yiz/rxo=";
  };
  
  nativeBuildInupts = [
    
  ];
  buildInputs = [
    gmp
    ncurses
  ];

  # buildPhase = ''
  #   make all
  # '';
  installPhase = ''
    mkdir -p $out/bin
    cp fracterm $out/bin
    cp cinematograph $out/bin
  '';
  
}
