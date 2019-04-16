#!/bin/sh
. /etc/profile
UNDEPLOY_DIR="$JBOSS_HOME/server/default/undeploy"
DEPLOY_DIR="$JBOSS_HOME/server/default/deploy"
result = `mv "$DEPLOY_DIR/$1" "$DEPLOY_DIR/$2" "$UNDEPLOY_DIR/"`
echo succuss
exit 0

