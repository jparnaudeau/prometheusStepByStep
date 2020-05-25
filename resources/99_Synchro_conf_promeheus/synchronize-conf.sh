#!/bin/sh

if [ -z ${AWS_PROFILE} ]; then
  echo "Please export your AWS_PROFILE"
  exit 1
fi

if [ $# -ne 1 ]
then
   echo "$0 <environment>"
   exit 1
fi

export CONFIGURATION=`echo $1|sed 's/\///g'`

echo "Synchronizing from local to s3."
aws s3 cp ${CONFIGURATION} s3://ippevent-jparnaudeau-${CONFIGURATION}-ippevent-prometheus-config/prometheus/ '--include=*.yml' --recursive