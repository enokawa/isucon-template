#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  env.sh
  webapp/python/main.py
  webapp/sql/0_Schema.sql
)

for server in ${servers[@]}
do
  echo "============= ${server} ============="
  # Stop Go service and enable Python service
  ssh ${server} sudo systemctl stop isucondition.go.service
  ssh ${server} sudo systemctl disable isucondition.go.service
  ssh ${server} sudo systemctl enable isucondition.python.service

  # Stop Python service
  ssh ${server} sudo systemctl stop isucondition.python.service

  for file in ${files[@]}
  do
    scp ../${file} ${server}:/home/isucon/${file}
  done

  # Lotate Logs
  # ssh ${server} "sudo gzip -c /var/log/nginx/access.log > /var/tmp/access.log.$(date +%Y%m%d-%H%M%S)"
  ssh ${server} sudo rm -f /var/log/nginx/access.log
  
  # Restart services
  ssh ${server} sudo systemctl start isucondition.python.service
  ssh ${server} sudo mysqladmin flush-logs
  ssh ${server} sudo nginx -s reopen
  echo "============= ${server} ============="
  echo
done