#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  etc/nginx/nginx.conf
  etc/nginx/sites-available/isucon.conf
)

for server in ${servers[@]}
do
  echo "============= ${server} ============="
  for file in ${files[@]}
  do
    ssh ${server} mkdir -p etc/nginx/sites-available
    scp ../${file} ${server}:${file}

    ssh ${server} sudo cp ${file} /${file}
  done

  # Lotate Nginx Logs
  # ssh ${server} "sudo gzip -c /var/log/nginx/access.log > /var/tmp/access.log.$(date +%Y%m%d-%H%M%S)"
  ssh ${server} sudo rm -f /var/log/nginx/access.log
  
  # Restart Nginx service
  ssh ${server} "sudo nginx -t && sudo nginx -s reopen"
  ssh ${server} "sudo systemctl restart nginx"
  echo "============= ${server} ============="
  echo
done