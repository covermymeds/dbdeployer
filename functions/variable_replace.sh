#!/usr/bin/env bash
function variable_replace() {
  _variable="${1}"
  _replace="${2}"
  _string="${3}"



  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi

}
