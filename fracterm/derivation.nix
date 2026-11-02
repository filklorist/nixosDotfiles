{ stdenv, fetchFromGitHub, gmp, ncurses, notcurses, lib }:

stdenv.mkDerivation {
  pname = "fracterm";
  version = "0.3";

  src = fetchFromGitHub {
    owner = "dovskyi";
    repo = "fracterm";
    rev = "e8e451a";
    sha256 = "U9b/0T2b0K9AewTdR7poSSSb8nmJLj3bS4a4+wQpNFI=";
    # hash=lib.fakeHash;
  };
  
  nativeBuildInupts = [
    
  ];
  buildInputs = [
    gmp
    ncurses
    notcurses
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
