# References used:
# http://gliderlabs.viewdocs.io/docker-alpine
# https://github.com/docker/compose/blob/master/Dockerfile
FROM gliderlabs/alpine:3.1
MAINTAINER nakanaa

# Set correct environment variables
ENV REFRESHED_AT 27.02.2015
ENV HOME /root
ENV APP /app
WORKDIR $HOME

# Install Python, pip & cURL
RUN apk add --update python py-pip curl

ENV COMPOSE_VERSION 1.1.0

RUN \
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
  rm -rf *

WORKDIR $APP

ENTRYPOINT ["/usr/bin/docker-compose"]
