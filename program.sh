#!/bin/bash

repl(){
  clj -M:repl
}


main(){
  clojure -M:main
}


uberjar(){

  mv target/deathstar.standalone.jar target/jpackage-input/

}

j-package(){
  OS=${1:?"Need OS type (windows/linux/mac)"}

  echo "Starting compilation..."

  if [ "$OS" == "windows" ]; then
    J_ARG="--win-menu --win-dir-chooser --win-shortcut"
          
  elif [ "$OS" == "linux" ]; then
      J_ARG="--linux-shortcut"
  else
      J_ARG=""
  fi

  APP_VERSION=0.1.0

  jpackage \
    --input target/jpackage-input \
    --dest target \
    --main-jar deathstar.standalone.jar \
    --name "deathstar" \
    --main-class clojure.main \
    --arguments -m \
    --arguments deathstar.main \
    --java-options -Xmx2048m \
    --app-version ${APP_VERSION} \
    $J_ARG
  
}

"$@"