#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  env.sh
  webapp/NoImage.jpg
  webapp/ec256-public.pem
  webapp/python
  webapp/sql 
)

mkdir webapp

for file in ${files[@]}
do
  scp -r ${servers[0]}:/home/isucon/${file} ../webapp/
done

mv ../webapp/env.sh ../