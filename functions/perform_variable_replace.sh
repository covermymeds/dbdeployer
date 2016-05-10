#!/usr/bin/env bash
function perform_variable_replace() {
  _variable="${1}"
  _replace="${2}"
  _file="${3}"

  #echo "sed -i \"s/${_variable}/${_replace}/g\" \"${_file}\""
  sed -i "s/${_variable}/${_replace}/g" "${_file}"

  if [ ${?} -eq 0 ]
  then
    unset _variable
    unset _replace
    return 0
  else
    return 1
  fi

}
