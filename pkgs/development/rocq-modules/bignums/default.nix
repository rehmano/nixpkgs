{
  lib,
  mkRocqDerivation,
  rocq-core,
  stdlib,
  version ? null,
}:

mkRocqDerivation {
  pname = "bignums";
  owner = "coq";
  inherit version;
  defaultVersion =
    with lib.versions;
    lib.switch rocq-core.rocq-version (lib.lists.sort (x: y: isLe x.out y.out) (
      lib.mapAttrsToList (out: case: { inherit case out; }) {
        "9.0.0+rocq${rocq-core.rocq-version}" = range "9.0" "9.0";
      }
    )) null;

  release."9.0.0+rocq9.0".sha256 = "sha256-ctnwpyNVhryEUA5YEsAImrcJsNMhtBgDSOz+z5Z4R78=";
  releaseRev = v: "${if lib.versions.isGe "9.0" v then "v" else "V"}${v}";

  mlPlugin = true;

  propagatedBuildInputs = [ stdlib ];

  meta = {
    license = lib.licenses.lgpl2;
  };
}
