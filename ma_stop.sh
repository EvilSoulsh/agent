#!/bin/sh
#stop oss by mv the ma-ear.ear from deploy directory
. /etc/profile

MA_DEPLOY_FILE="$JBOSS_HOME/server/default/deploy/ma-ear.ear"
UNDEPLOY_DIR="$JBOSS_HOME/server/default/undeploy"
mv $MA_DEPLOY_FILE $UNDEPLOY_DIR
if [ "$?" -gt "0" ];then
echo error
exit 1
fi


