# Prometheus Companion Dockerfile

ARG NODE_LTS_VERSION
FROM node:${NODE_LTS_VERSION}-buster-slim AS BASE

RUN apt update && apt -y upgrade && \
    apt remove -y python2.7 linux-libc-dev && apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN node --version && \
    npm --version

RUN cd /usr/local/lib/node_modules/npm/ && \
    npm update

USER root
ENV PORT=9090 DST_PORT=9099

COPY ./synchronize.sh /synchronize.sh

RUN chmod +x /synchronize.sh && \
    apt-get update && \
	apt remove -y python2.7 linux-libc-dev && apt autoremove -y && \
    apt-get install -y \
    curl unzip sed \
    python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install awscli && \
    aws --version && \
    # cleanup
    chmod -R u-s /usr/local/lib/python3.7 && chmod -R g-s /usr/local/lib/python3.7 && \
    chmod -R g-s /usr/lib/dbus-1.0/dbus-daemon-launch-helper && chmod -R u-s /usr/lib/dbus-1.0/dbus-daemon-launch-helper && \
    rm -rf /var/lib/apt/lists/*

COPY ["./server.js", "./package.json", "./package-lock.json", "/"]
RUN npm install

ENTRYPOINT ["node", "./server.js"]
