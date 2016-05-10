#!/usr/bin/env bash
function variable_replace() {
  _key_value_pair="${1}"
  _file="${3}"

  # only run below if we have a value in the variable
  if [ ${#_key_value_pair} -gt 0 ]
  then

    IFS=',' read -r -a key_value_array <<< "${_key_value_pair}"

    for element in "${key_value_array[@]}"
    do

      # check that we have a colon separator for the value we are evaluating and 
      # error if not
      if [[ $element == *':'* ]]
      then
        variable_replace_key=`echo "${element}" | awk -F ':' {'print $1'}`
        variable_replace_val=`echo "${element}" | awk -F ':' {'print $2'}`
        echo "Key: ${variable_replace_key}, Value: ${variable_replace_val}"
      else
        echo "The ':' value is a separator for key:value pairs used for variable replacement"
        echo "and must be present in variables_to_replace in the config or the '-o' option"
        return 1
      fi

      # call replace function
      #perform_variable_replace "${variable_replace_key}" "${variable_replace_val}" "${_file}"
      if [ ${?} -ne 0 ]
      then
        return 1
      fi

    done
  else
    echo "Variable replace is turned on, but the variable is empty. Try setting"
    echo "variables_to_replace in the config or use the '-o' option on the CLI"
    
    return 0
  fi
}
