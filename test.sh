#!/bin/sh
. ./.env

NAMESPACE="test"
DATABASE="testdb"

check_env() {
  if [ -z "$2" ]; then
    echo "invalid environment valiable : $1"
    exit 255
  fi
}

check_cmd() {
  which curl > /dev/null || (echo "curl not found"; exit 255)
  which jq   > /dev/null || (echo "jq not found"; exit 255)
}

post() {
  data=$1
  curl -s --request POST                           \
    --header "Accept: application/json"            \
    --header "NS: ${NAMESPACE}"                    \
    --header "DB: ${DATABASE}"                     \
    --user "${SURREALDB_USER}":"${SURREALDB_PASS}" \
    --data "${data}" http://localhost:8000/sql | jq
}

check_cmd
check_env SURREALDB_USER "${SURREALDB_USER}"
check_env SURREALDB_PASS "${SURREALDB_PASS}"

post "INFO FOR DB;"
