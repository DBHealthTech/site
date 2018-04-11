#!/bin/bash

set -euo pipefail

sudo docker build -t docker.nbsoftsolutions.com/nbsoftsolutions/dbhealthtech .
sudo docker push docker.nbsoftsolutions.com/nbsoftsolutions/dbhealthtech

ssh -t root@67.205.181.121 'docker pull docker.nbsoftsolutions.com/nbsoftsolutions/dbhealthtech && cd dbhealthtech && docker-compose up -d'
