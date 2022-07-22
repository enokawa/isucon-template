#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  home/isucon/env.sh
  home/isucon/webapp/NoImage.jpg
  home/isucon/webapp/ec256-public.pem
  home/isucon/webapp/python
  home/isucon/webapp/sql 
)

mkdir webapp

for file in ${files[@]}
do
  scp -r ${servers[0]}:/$file ../webapp/
done

mv ../webapp/env.sh ../