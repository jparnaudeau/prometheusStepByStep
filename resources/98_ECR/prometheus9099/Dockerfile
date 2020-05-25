ARG PROMETHEUS_VERSION

FROM prom/prometheus:${PROMETHEUS_VERSION}
USER       root

ENV PROM_CONF_DIR=/etc/prometheus \
    STORAGE_TSDB_PATH=/prometheus \
    STORAGE_TSDB_RETENTION=14d \
    PROM_PORT=9099

COPY docker-entrypoint.sh /etc/prometheus/entrypoint.sh
COPY prometheus_minimal.yml /etc/prometheus/prometheus.yml

RUN chmod +x /etc/prometheus/entrypoint.sh
RUN mkdir -p /prometheus-config ; mkdir -p /prometheus && \
    chown -R nobody:nogroup /etc/prometheus /prometheus /prometheus-config

EXPOSE     9099
VOLUME     [ "/prometheus-config", "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/etc/prometheus/entrypoint.sh" ]
