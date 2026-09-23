{ lib
, python3Packages
, fetchFromGitHub
, cmake
, ninja
, pkg-config
, openssl
, vcpkg
}:

python3Packages.buildPythonPackage rec {
  pname = "dave-py";
  version = "1.0.0";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "DisnakeDev";
    repo = "dave.py";
    rev = "v${version}";
    sha256 = "Ej4l9U4THfHG3XienHvuz3fyUJyTgYSw0Mn2nKPzkek=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with python3Packages; [
    nanobind
    scikit-build-core
  ] ++ [
    cmake
    ninja
    pkg-config
    vcpkg
  ];

  cmakeFlags = [
    "-DCMAKE_TOOLCHAIN_FILE=${vcpkg}/share/vcpkg/scripts/buildsystems/vcpkg.cmake"
  ];
  postConfigure = ''
    echo "===== VCPKG BOOTSTRAP LOG ====="
    cat build/vcpkg-bootstrap.log || true
    echo "===== END VCPKG BOOTSTRAP LOG ====="
  '';

  buildInputs = [
    openssl
  ];

  meta = {
    description = "Python bindings for Discord's libdave DAVE protocol implementation";
    homepage = "https://github.com/DisnakeDev/dave.py";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
