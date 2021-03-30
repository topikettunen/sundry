FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    netcat \
    docker.io

ENV STATSD_HOST="telegraf"
ENV STATSD_PORT="8125"
ENV STATSD_PREFIX="docker"
ENV INTERVAL="2"

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
