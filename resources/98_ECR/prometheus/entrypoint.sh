#!/bin/sh

/bin/prometheus --storage.tsdb.path ${STORAGE_TSDB_PATH} --storage.tsdb.retention.time ${STORAGE_TSDB_RETENTION} \
                --config.file ${PROM_CONF_DIR}/prometheus.yml \
                --web.enable-lifecycle \
                --web.console.libraries=/usr/share/prometheus/console_libraries \
                --web.console.templates=/usr/share/prometheus/consoles \
                --web.external-url=${EXTERNAL_URL} \
                --web.listen-address="0.0.0.0:${PROM_PORT}"
