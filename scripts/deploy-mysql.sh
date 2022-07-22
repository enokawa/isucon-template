#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  etc/mysql/mysql.conf.d/mysqld.cnf
  # etc/mysql/mariadb.conf.d/50-server.cnf
)

for server in ${servers[@]}
do
  echo "============= ${server} ============="
  for file in ${files[@]}
  do
    ssh ${server} mkdir -p etc/mysql/mysql.conf.d
    # ssh ${server} mkdir -p etc/mysql/mariadb.conf.d
    scp ../${file} ${server}:${file}

    ssh ${server} sudo cp ${file} /${file}
  done

  # Lotate Logs
  # ssh ${server} sudo gzip -c /var/log/mysql/mysql-slow.log > /var/log/mysql/mysql-slow.log.$(date +%Y%m%d-%H%M%S)
  # ssh ${server} sudo rm -f /var/log/mysql/mysql-slow.log
  
  # Restart MySQL service
  ssh ${server} sudo mysqladmin flush-logs
  ssh ${server} sudo systemctl restart mysql.service
  echo "============= ${server} ============="
  echo
done