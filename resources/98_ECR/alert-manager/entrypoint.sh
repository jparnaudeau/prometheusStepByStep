#!/bin/sh

/bin/alertmanager --config.file /etc/alertmanager/alertmanager.yml  --web.external-url="http://ippenvent-alertmanager.sbx.aws.ippon.fr:9093/"
