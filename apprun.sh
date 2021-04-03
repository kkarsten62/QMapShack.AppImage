#! /usr/bin/env bash

set -e
this_dir=$(readlink -f $(dirname "$0"))
export GDAL_DATA=$APPDIR/usr/share/gdal
"$this_dir"/usr/bin/qmapshack

