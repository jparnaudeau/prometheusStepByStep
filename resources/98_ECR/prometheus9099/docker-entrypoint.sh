#!/bin/sh

# at the beginning, the first time, it could be possible that the minimal prometheus config file
# ${PROM_CONF_DIR}/prometheus.yml does not exists
# we need to copy the /etc/prometheus/prometheus.yml file in PROM_CONF_DIR
if [ "${PROM_CONF_DIR}" != "/etc/prometheus" ]
then
  mkdir -p ${PROM_CONF_DIR}/rules
  if [ ! -f "${PROM_CONF_DIR}/prometheus.yml" ]
  then 
    cp /etc/prometheus/prometheus.yml ${PROM_CONF_DIR}/prometheus.yml
  fi
fi

# --storage.tsdb.path ${STORAGE_TSDB_PATH} --storage.tsdb.retention.time ${STORAGE_TSDB_RETENTION} \

/bin/prometheus --config.file ${PROM_CONF_DIR}/prometheus.yml \
                --web.enable-lifecycle \
                --web.console.libraries=/usr/share/prometheus/console_libraries \
                --web.console.templates=/usr/share/prometheus/consoles \
                --web.external-url=${EXTERNAL_URL} \
                --web.listen-address="0.0.0.0:${PROM_PORT}"
