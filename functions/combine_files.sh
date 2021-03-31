#!/usr/bin/env bash
function combine_files() {
  _target_file="${1}"
  _file_1="${2}"
  _file_2="${3}"
  _file_3="${4}"


  echo "$(cat "${_file_1}" >  "${_target_file}")"
  echo "$(cat "${_file_2}" >>  "${_target_file}")"
  echo "$(cat "${_file_3}" >>  "${_target_file}")"

  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi

}
