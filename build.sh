#!/bin/bash

set -eou pipefail

function zop_file {
    zopfli "${1}"
    touch -r "${1}" "${1}.gz"
}

export -f zop_file

hugo

find ./public \( -type f -iname "*.html" -o -iname "*.js" -o -iname "*.css" \) -exec bash -c 'zop_file "$0"' {} \;
