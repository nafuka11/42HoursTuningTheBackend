#!/bin/bash -e

TIME=`date +%d%H%M%S`
LOG_DIR="../logs"

cd scoring/
mkdir -p "${LOG_DIR}"
bash evaluate.sh > "${LOG_DIR}/result-${TIME}_stdout.log" 2> "${LOG_DIR}/result-${TIME}_stderr.log"

MYSQL_CONTAINER_ID=`docker ps -f ancestor=development_mysql -q`
NGINX_CONTAINER_ID=`docker ps -f ancestor=development_nginx -q`

docker cp "${MYSQL_CONTAINER_ID}:/var/log/mysql-slow.log" "${LOG_DIR}/mysql-slow-${TIME}.log"
pt-query-digest "${LOG_DIR}/mysql-slow-${TIME}.log" > "${LOG_DIR}/pt-query-digest-${TIME}.log"

docker cp "${NGINX_CONTAINER_ID}:/var/log/nginx/nginx-access.log" "${LOG_DIR}/nginx-access-${TIME}.log"
cat "${LOG_DIR}/nginx-access-${TIME}.log" | alp ltsv -m '/api/client/records/[^/]+/comments,/api/client/records/[^/]+/files/[^/]+,/api/client/records' > "${LOG_DIR}/alp-${TIME}.log"
