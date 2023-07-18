FROM alpine:latest
LABEL mantainer="myelectronix"

ARG XRAY_CORE_VERSION=v1.8.3

RUN set -e &&\
    apk add bash &&\
    wget https://github.com/XTLS/Xray-core/releases/download/${XRAY_CORE_VERSION}/Xray-linux-64.zip &&\
    mkdir /opt/xray &&\
    mkdir /opt/xray/config &&\
    unzip ./Xray-linux-64.zip -d /opt/xray  &&\
    rm -rf Xray-linux-64.zip

COPY config.json /opt/xray/config/config.json
COPY entrypoint.sh /opt/xray/entrypoint.sh

VOLUME [ "/opt/xray/config" ]
EXPOSE 443
ENTRYPOINT [ "/bin/sh" ]



