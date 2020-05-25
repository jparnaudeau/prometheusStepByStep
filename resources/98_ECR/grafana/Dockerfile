# Grafana Dockerfile

ARG GRAFANA_VERSION

FROM grafana/grafana:$GRAFANA_VERSION
USER root

RUN apk update && apk upgrade && \
    apk add py3-pip git && \
    pip3 install --upgrade --no-cache-dir awscli && \
# Install piechart plugin
    mkdir -p /var/lib/grafana/plugins/grafana-piechart-panel && \
    git clone https://github.com/grafana/piechart-panel.git --branch v1.4.0 && \
    mv piechart-panel /var/lib/grafana/plugins/grafana-piechart-panel && \
# Install diagram panel
    mkdir -p /var/lib/grafana/plugins/grafana-diagram && \
    git clone https://github.com/jdbranham/grafana-diagram.git --branch v1.6.2 && \
    mv grafana-diagram /var/lib/grafana/plugins/grafana-diagram && \
# Cleanup
    rm -rf /var/cache/apk/* && \
    apk del git && \
# Configure Grafana
    chown -R grafana:grafana /etc/grafana/ && \
    chown -R grafana:grafana /var/lib/grafana/plugins && \
    chmod -R 750 /home/grafana 

USER grafana
