#!/bin/sh

set -e # stop on error

echo "Synchronizing from s3 <${CONF_BUCKET_NAME}>  to local."

echo aws s3 cp --recursive s3://${CONF_BUCKET_NAME}/ /prometheus-config/

echo ---------
ls -lR  /prometheus-config/
echo ---------

aws s3 cp --recursive s3://${CONF_BUCKET_NAME}/ /prometheus-config/

# EC2  : LOCAL_HOSTNAME=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
LOCAL_HOSTNAME='127.0.0.1'

echo local hostname: -- ${LOCAL_HOSTNAME} --

# replace generic value with hostname
sed -i "s/_BLACKBOX_TASK_NAME_/${LOCAL_HOSTNAME}/g" /prometheus-config/prometheus.yml
sed -i "s/_CLOUDWATCH_TASK_NAME_/${LOCAL_HOSTNAME}/g" /prometheus-config/prometheus.yml
sed -i "s/_CLUSTER_NAME_/${CLUSTER_NAME}/g" /prometheus-config/prometheus.yml
sed -i "s/_ECS_EC2_CLUSTER_NAME_/${ECS_EC2_CLUSTER_NAME}/g" /prometheus-config/prometheus.yml
sed -i "s/_ALERTMANAGER_TASK_NAME_/${LOCAL_HOSTNAME}/g" /prometheus-config/prometheus.yml
sed -i "s/_VPCLIMIT_EXPORTER_TASK_NAME_/${LOCAL_HOSTNAME}/g" /prometheus-config/prometheus.yml
sed -i "s/_PUSHGATEWAY_EXPORTER_TASK_NAME_/${LOCAL_HOSTNAME}/g" /prometheus-config/prometheus.yml

echo "Reload Configuration : [curl -X POST http://${LOCAL_HOSTNAME}:9099/-/reload]"
curl -X POST http://${LOCAL_HOSTNAME}:9099/-/reload

echo "Configuration Reloaded"
