#!/bin/bash


NODE_VERSIONS=( "14.16.0" )

# Makes sure nvm is installed.
if ! which nvm > /dev/null; then
  rm -rf ~/.nvm/ &&\
    git clone --depth 1 https://github.com/creationix/nvm.git ~/.nvm
  source ~/.nvm/nvm.sh
fi

for i in "${NODE_VERSIONS[@]}"; do
   # Installs and use the correct version of node
   nvm install $i
   nvm use $i

   # build, package and publish for the current package version
   npm install nan
   npm install aws-sdk
   npm install @mapbox/node-pre-gyp
   ./node_modules/@mapbox/node-pre-gyp/bin/node-pre-gyp clean configure build package publish
done
