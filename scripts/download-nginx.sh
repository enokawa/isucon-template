#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  etc/nginx/nginx.conf
  etc/nginx/sites-available/isucon.conf
)

for file in ${files[@]}
do
  scp ${servers[0]}:/${file} ../${file}
done