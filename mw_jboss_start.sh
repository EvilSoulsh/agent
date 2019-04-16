#!/bin/sh
. /etc/profile
DEPLOY_DIR="$JBOSS_HOME/server/default/deploy/"
UNDEPLOY_DIR="$JBOSS_HOME/server/default/undeploy"
mv ${UNDEPLOY_DIR}/*.ear $DEPLOY_DIR
service jboss killstart
echo succuss
exit 0
