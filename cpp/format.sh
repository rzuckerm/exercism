#!/bin/bash
set -e
PROJECT="$(basename "$(realpath "$(dirname .)")" | sed 's/-/_/g')"
set -x
clang-format '--style=file:../../cpp/.clang-format' -i "${PROJECT}.h" "${PROJECT}.cpp"
