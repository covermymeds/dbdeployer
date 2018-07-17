function set_password_flags() {
  PGPASSWORD=${password}
  echo "PGPASSWORD: ${PGPASSWORD}"
  return 0
}
