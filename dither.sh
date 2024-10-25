#!/bin/bash

set -eux -o pipefail

# Get the directory that this script file is in
THIS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

cd "$THIS_DIR"

IN="$1"
AMOUNT="${2:-50}"
OUT="${IN%.*}.cga.png"

magick "$IN" \
	-resize x200 \
	-define dither:diffusion-amount="$AMOUNT"% \
	-dither FloydSteinberg \
	-remap cga-palette.png \
	-filter Point \
	-resize 400% \
	"$OUT"

open -R "$OUT"
