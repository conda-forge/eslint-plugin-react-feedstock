#!/bin/sh

set -exuo pipefail

if [[ "${target_platform}" == "osx-arm64" ]]; then
    export npm_config_arch="arm64"
fi
# Don't use pre-built gyp packages
export npm_config_build_from_source=true
export NPM_CONFIG_USERCONFIG=/tmp/nonexistentrc

rm $PREFIX/bin/node
ln -s $BUILD_PREFIX/bin/node $PREFIX/bin/node

yarn install --frozen-lockfile
yarn pack
yarn licenses generate-disclaimer > ThirdPartyLicenses.txt

npm install -g ${PKG_NAME}-v${PKG_VERSION}.tgz
