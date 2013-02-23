#! /bin/bash

me=`basename $0`
dir=`dirname $0`

cd $dir

# load all the submodules in
git submodule update --init

echo "=== Symlinking dotfiles / directories"
for src in $(find $PWD -maxdepth 1); do
  file=`basename $src`

  if [[
    $file != '.git' &&
    $file != '.'    &&
    $file != '..'   &&
    $file != 'node_modules'   &&
    $file != '.gitmodules'   &&
    $file != $me
  ]]; then
    echo "Symlinking $file from $src"
    ln -Ffs $src ~/
  fi
done

# Resume previous directory
cd - > /dev/null

echo "=== Done!"
