#!/usr/bin/env bash
function db_exists() {
  _check_db="$1"

  eval `[[ "${_check_db}" =~ ^${dbname_regex}$ ]] && return 0 || return 1`
  rc=$?
  if [ $rc -eq 0 ]
  then
    # the below way should work if you are just listing databases but is more intense than using system tables
    # I commented this out and left in place in the event another engine needs to utilize this method
    #    if [ `${db_binary} ${server_flag} ${user_flag} ${port_flag} -1 -X -q -t -c '\l' | \
    #    awk -F'|' {'print $1'} | \
    #    sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | \
    #    grep "^${_check_db}$" | \
    #    wc -l | \
    #    xargs` -eq 1 ]

    query_output=`${switch_user_flag} ${db_binary} ${server_flag} ${user_flag} ${port_flag} ${encryption_flag} -1 -X -q -t -d postgres -c "
    select coalesce ((SELECT count(datname)
    FROM pg_database
    where datname= '${_check_db}'
    ),0);" | xargs`

    if [ "${query_output}" == "1" ]
    then
      rc=0
    else
      rc=1
    fi
  else
    rc=1
  fi

  unset _check_db

  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi
}
