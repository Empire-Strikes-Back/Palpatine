#!/bin/bash

repl(){
  clj \
    -J-Dclojure.core.async.pool-size=1 \
    -X:repl Ripley.core/process \
    :main-ns Palpatine.main
}

main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -M -m Palpatine.main
}

uberjar(){

  clojure \
    -X:identicon Zazu.core/process \
    :word '"Palpatine"' \
    :filename '"out/identicon/icon.png"' \
    :size 256

  rm -rf out/*.jar
  clojure \
    -X:uberjar Genie.core/process \
    :main-ns Palpatine.main \
    :filename "\"out/Palpatine-$(git rev-parse --short HEAD).jar\"" \
    :paths '["src" "out/identicon"]'
}

release(){
  uberjar
}

"$@"