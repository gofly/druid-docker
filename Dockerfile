FROM openjdk:8-jre-alpine
ENV DRUID_VERSION="0.10.0" \
    MYSQL_METADATA_STORAGE_VERSION="0.10.0" \
    MYSQL_CONNECTOR_VERSION="5.1.42"
RUN apk add --no-cache --virtual .build-deps curl && \
    mkdir -p /opt && \
    curl -L http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz | tar zx -C /opt && \
    mv /opt/druid-$DRUID_VERSION /opt/druid && \
    curl -L http://static.druid.io/artifacts/releases/mysql-metadata-storage-$MYSQL_METADATA_STORAGE_VERSION.tar.gz | tar zx -C /opt/druid/extensions && \
    rm /opt/druid/extensions/mysql-metadata-storage/mysql-connector-java-*.jar && \
    curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.tar.gz | tar zx && \
    mv mysql-connector-java-$MYSQL_CONNECTOR_VERSION/mysql-connector-java-$MYSQL_CONNECTOR_VERSION-bin.jar /opt/druid/extensions/mysql-metadata-storage/ && \
    rm -rf mysql-connector-java-$MYSQL_CONNECTOR_VERSION && \
    apk del .build-deps
ADD docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh && \
    mkdir -p /opt/druid/tmp /opt/druid/var
VOLUME ["/opt/druid/tmp", "/opt/druid/var"]
ENTRYPOINT ["/docker-entrypoint.sh"]
