#!/bin/bash

set -eu

readonly ALP_VERSION="v1.0.15"

echo "###################################################"

# Ignore login message such as below:
# `Welcome to Ubuntu 20.04.4 LTS ...`
if test -f /home/ubuntu/.hushlogin; then
  echo "[skip] /home/ubuntu/.hushlogin has exists."
else
  echo "/home/ubuntu/.hushlogin has not exists. Will create that file."
  touch /home/ubuntu/.hushlogin
fi

echo "###################################################"

if test -f /home/isucon/.hushlogin; then
  echo "[skip] /home/isucon/.hushlogin has exists."
else
  echo "/home/isucon/.hushlogin has not exists. Will create that file."
  sudo touch /home/isucon/.hushlogin
fi

echo "###################################################"

# Install utilities
## Percona Toolkit: https://www.percona.com/downloads/percona-toolkit/LATEST/
if test -f /usr/bin/pt-query-digest; then
  echo "[skip] Percona Toolkit has allready installed."
else
  echo "Percona Toolkit has not installed. Installing..."
  sudo apt-get install -y percona-toolkit
fi

echo "###################################################"

## alp: https://github.com/tkuchiki/alp/releases
if test -f /usr/local/bin/alp; then
  echo "[skip] alp has allready installed."
else
  echo "alp has not installed. Installing..."
  curl -LO https://github.com/tkuchiki/alp/releases/download/${ALP_VERSION}/alp_linux_amd64.tar.gz
  tar xvzf alp_linux_amd64.tar.gz
  sudo mv alp /usr/local/bin/alp
  rm -f alp_linux_amd64.tar.gz
fi

echo "###################################################"

# Setup isucon user

if test -f /home/isucon/.ssh/authorized_keys; then
  echo "[skip] isucon user setting up has allready done."
else
  echo "isucon user has not setting up. Setting.."
  sudo mkdir /home/isucon/.ssh
  sudo chmod 700 /home/isucon/.ssh
  sudo touch /home/isucon/.ssh/authorized_keys
  sudo chmod 600 /home/isucon/.ssh/authorized_keys
  sudo chown -R isucon:isucon /home/isucon/.ssh/
  sudo curl -s https://github.com/enokawa.keys >> /home/isucon/.ssh/authorized_keys
  sudo curl -s https://github.com/kikulabo.keys >> /home/isucon/.ssh/authorized_keys
  sudo curl -s https://github.com/mmclsntr.keys >> /home/isucon/.ssh/authorized_keys
fi

echo "###################################################"

# Uninstall utilities
# sudo apt remove -y percona-toolkit
# sudo apt purge -y percona-toolkit
# sudo rm -rf /usr/local/bin/alp
