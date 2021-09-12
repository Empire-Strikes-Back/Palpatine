#!/bin/bash

repl(){
  clj \
    -J-Dclojure.core.async.pool-size=1 \
    -X:repl Ripley.core/process \
    :main-ns Death-Star.main
}

main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -M -m Death-Star.main
}

uberjar(){

  clojure \
    -X:identicon Zazu.core/process \
    :word '"Death-Star"' \
    :filename '"out/identicon/icon.png"' \
    :size 256

  clojure \
    -X:uberjar Genie.core/process \
    :main-ns Death-Star.main \
    :filename '"out/Death-Star.jar"' \
    :paths '["src" "out/identicon"]'
}

release(){
  uberjar
}

"$@"