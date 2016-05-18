#!/usr/bin/env bash
function check_server_ping() {
  if [ "${enable_ping}" != 'false' ]
  then
    ping -c ${ping_count} -W ${ping_wait} -i ${ping_interval} "${server}" &> /dev/null

    if [ $? -eq 0 ]
    then
      return 0
    else
      echo "Unable to ping the server specified, exiting"
      return 1
    fi
  fi

  return 0
}
