#!/bin/sh
#stop oss by mv the oss-ear.ear from deploy directory
. /etc/profile

OSS_DEPLOY_FILE="$JBOSS_HOME/server/default/deploy/oss-ear.ear"
UNDEPLOY_DIR="$JBOSS_HOME/server/default/undeploy"
mv $OSS_DEPLOY_FILE $UNDEPLOY_DIR
if [ "$?" -gt "0" ];then
echo error
exit 1
fi
