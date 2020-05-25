FROM prom/prometheus

USER root

COPY ./prometheus.yml /etc/prometheus/prometheus.yml
COPY ./entrypoint.sh /etc/prometheus/
COPY ./rules /etc/prometheus/rules

VOLUME ["prometheus-config"]

ENTRYPOINT [ "/etc/prometheus/entrypoint.sh" ]
