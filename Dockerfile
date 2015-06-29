# References used:
# http://gliderlabs.viewdocs.io/docker-alpine
# https://github.com/docker/compose/blob/master/Dockerfile
FROM gliderlabs/alpine:3.1
MAINTAINER nakanaa

# Set correct environment variables
ENV REFRESHED_AT 29.06.2015
ENV HOME /root
ENV APP /app
WORKDIR $HOME

# Install Python & pip
RUN apk-install python py-pip

ENV COMPOSE_VERSION 1.3.0

RUN \
  # Install cURL for downloading
  apk-install --virtual build-dependencies curl && \
  # Download Compose
  curl -LkO https://github.com/docker/compose/archive/${COMPOSE_VERSION}.zip && \
  # Extract
  unzip *.zip && \
  # Change directory
  cd */ && \
  # Download required packages
  pip install -r requirements.txt && \
  # Setup
  python setup.py install && \
  # Change directory back
  cd - && \
  # Remove downloaded files
  rm -rf * && \
  # Clean up
  apk del build-dependencies

WORKDIR $APP

ENTRYPOINT ["/usr/bin/docker-compose"]
