#!/bin/bash

# Run by ubuntu user

cd `dirname $0`

read servers < servers.txt

for server in ${servers[@]}
do
  echo "============= ${server} ============="
  scp setup.sh ${server}:/home/ubuntu/
  ssh ${server} sudo bash setup.sh
  ssh ${server} sudo hostnamectl set-hostname ${server} --static
  echo "============= ${server} ============="
  echo
done