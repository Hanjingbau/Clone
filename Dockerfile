FROM ghcr.io/thecaduceus/cbv2:main
    
# Customize using Gclone Library without unzip
RUN aria2c https://github.com/l3v11/gclone/releases/download/v1.59.0-abe/gclone_v1.59.0-abe-linux-arm64.zip \
    unzip gclone_v1.59.0-abe-linux-arm64.zip && \
    mv gclone_v1.59.0-abe-linux-arm64/gclone /usr/bin/ && \
    chmod +x /usr/bin/gclone && \
    rm -r gclone_v1.59.0-abe-linux-arm64

FROM ghcr.io/linuxserver/baseimage-ubuntu:arm64v8-jammy as runner
