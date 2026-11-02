{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, python3
, unzip
, mupdf
, freetype
, harfbuzz
, openjpeg
, jbig2dec
, gumbo
, zlib
, fontconfig
}:

rustPlatform.buildRustPackage rec {
  pname = "bookokrat";
  version = "0.3.12";

  src = fetchFromGitHub {
    owner = "bugzmanov";
    repo = "bookokrat";
    rev = "v${version}";
    sha256 = "OefSWMUtZdkXnebP2InvzmMCiSpLtN6ewsnzotQiOxY=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = [
    pkg-config
    python3
    rustPlatform.bindgenHook
    unzip
  ];

  buildInputs = [
    mupdf
    freetype
    harfbuzz
    openjpeg
    jbig2dec
    gumbo
    zlib
    fontconfig
  ];

  meta = {
    description = "Terminal ebook reader";
    homepage = "https://github.com/bugzmanov/bookokrat";
    license = lib.licenses.agpl3Plus;
    mainProgram = "bookokrat";
  };
}
