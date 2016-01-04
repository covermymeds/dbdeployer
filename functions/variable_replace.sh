#!/usr/bin/env bash
function variable_replace() {
  _variable="${1}"
  _replace="${2}"
  _file="${3}"
  _return_file"{4}"


  echo "$(cat "{_file}" | sed "s/\$(_variable)/\$(_replace)/g" > "${_return_file}")" 

  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi

}
