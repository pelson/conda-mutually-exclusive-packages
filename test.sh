#!/usr/bin/env bash

export CONDA_BLD_PATH="$HOME/conda-bld"

tmpdir=$(mktemp -d -t XXXX)
ARGS="-yq --override-channels -c file://${CONDA_BLD_PATH}"

set -ex
# should get just consumer (no provider)
conda create $ARGS -p $tmpdir/test-pkg-a pkg-a


conda create $ARGS -p $tmpdir/test-a-then-b pkg-a
conda remove $ARGS -p $tmpdir/test-a-then-b pkg-a
conda install $ARGS -p $tmpdir/test-a-then-b pkg-b


conda create $ARGS -p $tmpdir/test-both pkg-a pkg-b


set +x
for name in `ls "$tmpdir" | sort`; do
    conda list -p "$tmpdir/$name"
done

rm -rf $tmpdir
