{ lib
, python3Packages
, fetchFromGitHub
}:

python3Packages.buildPythonApplication rec {
  pname = "endcord";
  version = "1.5.4";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "sparklost";
    repo = "endcord";
    rev = version;
    sha256 = "ccpTm573Nhxj2AKvqSunE2ZZAemgox9hDakUSwvaw3s=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    cython
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "websocket-client"
    "python-socks"
    "orjson"
    "soundcard"
    "soundfile"
    "numpy"
    "pycryptodome"
  ];

  dependencies = with python3Packages; [
    websocket-client
    python-socks
    orjson
    soundcard
    soundfile
    numpy
    pycryptodome
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib/endcord

    cp -r endcord $out/lib/endcord/
    cp main.py $out/lib/endcord/

    makeWrapper ${python3Packages.python.interpreter} $out/bin/endcord \
      --add-flags "$out/lib/endcord/main.py" \
      --set PYTHONPATH "${python3Packages.makePythonPath dependencies}"

    runHook postInstall
  '';
  
  meta = {
    description = "The most feature rich Discord TUI client";
    homepage = "https://github.com/sparklost/endcord";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    mainProgram = "endcord";
  };
}
