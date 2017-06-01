FROM openjdk:8-jre-alpine
ENV JVM_XMS="24g" \
    JVM_XMX="24g" \
    JVM_XX_MAX_DIRECT_MEMORY_SIZE="4096m" \
    USER_TIMEZONE="UTC" \
    DRUID_VERSION="0.10.0"
RUN apk add --no-cache --virtual .build-deps curl && \
    mkdir -p /opt && \
    curl -L http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz | tar zx -C /opt && \
    mv /opt/druid-$DRUID_VERSION /opt/druid && \
    curl -L http://static.druid.io/artifacts/releases/mysql-metadata-storage-0.10.0.tar.gz | tar zx -C /opt/druid/extensions && \
    apk del .build-deps
ADD docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh && \
    mkdir -p /opt/druid/tmp
ENTRYPOINT ["/docker-entrypoint.sh"]
