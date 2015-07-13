#!/usr/bin/env bash
function check_server_ping() {
  
  ping -c 5 -W 2 -i 0.2 "${server}" &> /dev/null

  if [ $? -eq 0 ]
  then
    return 0
  else
    echo "Unable to ping the server specified, exiting"
    return 1
  fi
}
