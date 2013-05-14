#!/bin/bash


NODE=`which node`
if [ -x $NODE ]
  then
    cd SOURCE/;
    echo "Creating admin database"
    node dbSetup.js
    cd ..;
else
  echo "Please install node: apt-get install node";
fi