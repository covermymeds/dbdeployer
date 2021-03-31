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



    if [ `${db_binary} ${server_flag} ${port_flag} ${encryption_flag} ${user_flag} ${password_flag} -l0 -h -1 -Q "
    SET NOCOUNT ON;
    select coalesce ((SELECT count(name)
    FROM sys.databases
    where name= '${_check_db}'
    ),0);" | xargs` -eq 1 ]
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
