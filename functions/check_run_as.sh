#!/usr/bin/env bash
function check_run_as() {
  
  if [ "${deployed_as}" = "${run_as}" ]
  then
    return 0
  else
    return 1
  fi
}
