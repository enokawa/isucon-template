#!/bin/bash

# Run by isucon user

cd `dirname $0`

files=(
  etc/mysql/mysql.conf.d/mysqld.cnf
  # etc/mysql/mariadb.conf.d/50-server.cnf
)

for file in ${files[@]}
do
  scp isuconXX-qualify-1:/${file} ../${file}
done