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

  echo 1
}

release(){
  echo
}

"$@"