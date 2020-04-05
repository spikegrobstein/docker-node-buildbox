FROM ubuntu:18.04
MAINTAINER Spike Grobstein <me@spike.cx>

RUN apt-get update && apt-get install -y \
    tree \
    curl \
    build-essential \
    git \
    locales

# first install node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# set up locale stuff
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   

# create user that we build with
RUN useradd -s /bin/bash -m  -c "Builduser" build
RUN mkdir /build \
    && chown build /build

USER build

WORKDIR /build

ENV NODE_ENV=prod
