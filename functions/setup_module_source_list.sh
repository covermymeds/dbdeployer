#!/usr/bin/env bash
function setup_module_source_list() {

  old_IFS=$IFS

  IFS=','
  local module_dir_array=(${module_list})
  local module_array_count=`echo ${#module_dir_array[@]}`

  #echo "module_list: $module_list"
  #echo "module_array_count: $module_array_count"

  if [ ${module_array_count} -gt 0 ]
  then
    for ((i=0; i<${module_array_count}; i++))
    do
      # check if directory exists
      local plugin_dir="${module_basedir}/${module_dir_array[${i}]}"
      if [ -d ${plugin_dir} ]
      then
        load_functions_in_dirs "${plugin_dir}"
        echo "Loaded Plugin ${module_dir_array[${i}]}"
      else
        echo "Plugin dir ${plugin_dir} was not found, skipping"
      fi
    done
  fi
  IFS=${old_IFS}

}
