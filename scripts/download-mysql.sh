#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  etc/mysql/mysql.conf.d/mysqld.cnf
)

for file in ${files[@]}
do
  scp ${servers[0]}:/${file} ../${file}
done