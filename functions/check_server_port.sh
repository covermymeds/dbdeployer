#!/usr/bin/env bash
function check_server_port() {
  
  echo "" > /dev/tcp/${server}/${port}
  if [ $? -eq 0 ]
  then
    return 0
  else
    echo "Unable to connect to specified port \"${port}\" on the server ${server}, exiting"
    return 1
  fi
}
