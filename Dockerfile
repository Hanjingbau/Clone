FROM ghcr.io/linuxserver/baseimage-ubuntu:arm64v8-jammy

# Change as per VPS
WORKDIR /usr/src/clonebotv2
RUN sudo chmod 777 /usr/src/clonebotv2

# Make Non-Interactive
# ENV DEBIAN_FRONTEND="noninteractive"

# Or Add Time Zone
# ENV TZ= # Add Zone Here
# RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime
# RUN echo "$TZ" > /etc/timezone

RUN sudo apt-get update
RUN sudo apt-get install -y tzdata
RUN sudo apt-get -qq update

# Remove if using Gclone Library
RUN sudo apt install unzip -y

RUN sudo apt-get -qq install -y git python3 python3-pip \
    locales python3-lxml aria2 \
    curl pv jq nginx npm
    
# Customize using Gclone Library without unzip
RUN sudo aria2c https://github.com/l3v11/gclone/releases/download/v1.59.0-abe/gclone_v1.59.0-abe-linux-arm64.zip \
    unzip gclone_v1.59.0-abe-linux-arm64.zip && \
    sudo mv gclone_v1.59.0-abe-linux-arm64/gclone /usr/bin/ && \
    sudo chmod +x /usr/bin/gclone && \
    sudo rm -r gclone_v1.59.0-abe-linux-arm64

COPY requirements.txt .
RUN sudo pip3 install --no-cache-dir -r requirements.txt && \
    sudo apt-get -qq purge git

COPY . .

RUN sudo chmod +x run.sh

CMD ["bash","run.sh"]
