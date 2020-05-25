#!/bin/sh

export AWS_REGION="eu-west-3"
export AWS_ACCOUNT="448878779811"
export REPOSITORY_URL="${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"

if [ $# -ne 2 ]
then
   echo "$0 <directory> <version>"
   exit 1
fi

export DIR=`echo $1|sed 's/\///g'`
export VERSION=$2

# login to ecr
$(aws ecr get-login --no-include-email --registry-ids ${AWS_ACCOUNT} --region ${AWS_REGION})

if [ "${DIR}" = "prometheus" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/prometheus:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "prometheus9099" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/prometheus:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} --build-arg PROMETHEUS_VERSION="${VERSION}" ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "blackbox" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/blackbox:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} --build-arg PROMETHEUS_BLACKBOX_EXPORTER_VERSION="${VERSION}" ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "grafana" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/grafana:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} --build-arg GRAFANA_VERSION="${VERSION}" ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "prometheus_reloader" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/prometheus_reloader:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} --build-arg NODE_LTS_VERSION="12" ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "springboot" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/springboot:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "prometheus_ecs_discovery" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/prometheus_ecs_discovery:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} --build-arg PROM_ECS_DISCOVERY_VERSION="${VERSION}" ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "custom-exporter" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/custom_exporter:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} ${DIR}
   docker push ${DOCKER_IMG}

elif [ "${DIR}" = "alert-manager" ]
then
   DOCKER_IMG="${REPOSITORY_URL}/ippevent/alertmanager:${VERSION}"
   echo "build image $DOCKER_IMG"
   docker build -f ${DIR}/Dockerfile -t ${DOCKER_IMG} ${DIR}
   docker push ${DOCKER_IMG}

else
   echo "stack [$DIR] not found"
fi

