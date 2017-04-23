set -ex

CONDA_ROOT="$HOME/conda"
export CONDA_BLD_PATH="$HOME/conda-bld"
conda clean -tip --yes
rm -rf "$CONDA_ROOT/conda-bld"


LOCK_NAME=pkg_a conda build xclsv-pkg
LOCK_NAME=pkg_b conda build xclsv-pkg

conda build pkg-a pkg-b
