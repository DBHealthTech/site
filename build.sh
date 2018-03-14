#!/bin/bash

yarn run parcel build --out-dir themes/pb/dist --public-url './' themes/pb/index.html
yarn run parcel build --out-dir themes/pb/dist --public-url './' themes/pb/header.html
yarn run parcel build --out-dir themes/pb/dist --public-url './' themes/pb/footer.html

sed -i -e 's|http://{|{|g' themes/pb/dist/index.html

cp themes/pb/dist/index.html themes/pb/layouts/.
mkdir -p themes/pb/layouts/partials
cp themes/pb/dist/header.html themes/pb/layouts/partials/.
cp themes/pb/dist/footer.html themes/pb/layouts/partials/.
mkdir -p themes/pb/static
cp themes/pb/dist/* themes/pb/static/.
