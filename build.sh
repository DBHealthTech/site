#!/bin/bash

function zop_file {
    zopfli "${1}"
    touch -r "${1}" "${1}.gz"
}

export -f zop_file

yarn run parcel build --out-dir themes/pb/dist --public-url / themes/pb/index.html
yarn run parcel build --out-dir themes/pb/dist --public-url / themes/pb/header.html
yarn run parcel build --out-dir themes/pb/dist --public-url / themes/pb/footer.html

sed -i -e 's|http://{|{|g' themes/pb/dist/index.html

cp themes/pb/dist/index.html themes/pb/layouts/.
mkdir -p themes/pb/layouts/partials
cp themes/pb/dist/header.html themes/pb/layouts/partials/.
cp themes/pb/dist/footer.html themes/pb/layouts/partials/.
mkdir -p themes/pb/static
cp themes/pb/dist/* themes/pb/static/.

hugo

find ./public \( -type f -iname "*.html" -o -iname "*.js" -o -iname "*.css" \) -exec bash -c 'zop_file "$0"' {} \;
