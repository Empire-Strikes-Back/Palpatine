#!/bin/bash

repl(){
  clj -A:repl
}


main(){
  clojure -M:main
}


uberjar(){

  lein with-profiles +uberjar uberjar
  mkdir -p target/jpackage-input
  mv target/deathstar.standalone.jar target/jpackage-input/
  #  java -Dclojure.core.async.pool-size=1 -jar target/deathstar.standalone.jar
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

install_on_linux(){
  sudo dpkg --install target/deathstar_0.1.0-1_amd64.deb
}

"$@"