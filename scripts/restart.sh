#!/bin/bash

set -e # stop an any error

# Constants
ROOT_DIR="`pwd`/.."
PORT="1095"
VERSION=$(node -p "require('${ROOT_DIR}/package.json').version")
NODE="$(which node)"
GIT_COMMIT_SHA=$(git rev-parse HEAD)
GIT_REPOSITORY_URL="github.com/openwhyd/openwhyd"

# NGINX_ENBLD=/etc/nginx/sites-enabled
# NGINX_TEMPLATE=$ROOT_DIR/config/nginx-site-template
# sudo nginx -t # make sure that the configuration is valid
# sudo service nginx restart

echo "👋  Restarting Openwhyd server ${VERSION} on port ${PORT}, with ${NODE}..."
cd ${ROOT_DIR}
source env-vars-local.sh
DD_TAGS="git.commit.sha:${GIT_COMMIT_SHA},git.repository_url:${GIT_REPOSITORY_URL}" \
WHYD_PORT=${PORT} \
  npx --yes pm2 restart app.js --interpreter=${NODE}
