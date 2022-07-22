#!/bin/bash

# Run by isucon user

cd `dirname $0`

# on /home/isucon/
files=(
  env.sh
  webapp/NoImage.jpg
  webapp/ec256-public.pem
  webapp/python
  webapp/sql 
)

for file in ${files[@]}
do
  scp -r isucon11-qualify-1:/home/isucon/${file} ../${file}
done