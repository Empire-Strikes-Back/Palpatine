#!/bin/bash

repl(){
  clj \
    -J-Dclojure.core.async.pool-size=1 \
    -X:repl ripley.core/process \
    :main-ns deathstar.main
}

main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -M -m deathstar.main
}

uberjar(){

  clojure \
    -X:uberjar genie.core/process \
    :main-ns deathstar.main \
    :filename '"out/deathstar.jar"' \
    :paths '["src" "out/identicon"]'
}

release(){
  echo
}

"$@"