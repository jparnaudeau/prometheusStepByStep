FROM golang:1.13-alpine AS Build
ARG PROMETHEUS_BLACKBOX_EXPORTER_VERSION

RUN set -ex && apk --update --no-cache add \
    bash \
    build-base \
    curl \
    make \
    git \
    cmake

RUN git clone --branch ${PROMETHEUS_BLACKBOX_EXPORTER_VERSION} https://github.com/prometheus/blackbox_exporter && \
    cd blackbox_exporter && \
    make build

FROM quay.io/prometheus/busybox:latest
WORKDIR /go/blackbox

COPY --from=Build /go/blackbox_exporter/blackbox_exporter  /bin/blackbox_exporter
#COPY --from=Build /go/blackbox_exporter/blackbox.yml       /etc/blackbox_exporter/config.yml
COPY ./blackbox.yml       /etc/blackbox_exporter/config.yml

EXPOSE      9115
ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]
