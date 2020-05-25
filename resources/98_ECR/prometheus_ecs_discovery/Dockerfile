FROM alpine:latest

ARG PROM_ECS_DISCOVERY_VERSION
ENV PROM_ECS_DISCOVERY_URL "https://github.com/teralytics/prometheus-ecs-discovery/releases/download/${PROM_ECS_DISCOVERY_VERSION}/prometheus-ecs-discovery-linux-amd64"

RUN apk --no-cache add ca-certificates 
RUN wget $PROM_ECS_DISCOVERY_URL -O ./bin/prometheus-ecs-discovery && chmod u+x ./bin/prometheus-ecs-discovery

EXPOSE      9222
VOLUME     ["prometheus-config"]
CMD        prometheus-ecs-discovery -config.write-to=/prometheus-config/$ECSDISCOVERY_TARGET_CLUSTER.yml -config.cluster=$ECSDISCOVERY_TARGET_CLUSTER -config.scrape-times=0
