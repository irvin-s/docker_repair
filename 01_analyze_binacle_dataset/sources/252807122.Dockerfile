FROM anapsix/alpine-java

ENV AZURE_STORAGE_ACCESS_KEY ""
ENV AZURE_STORAGE_ACCOUNT ""
ENV AZURE_STORAGE_BLOB_CONTAINER ""
ENV AZURE_STORAGE_QUEUE ""
ENV INCIDENT_API_URL ""
ENV INCIDENT_RESOURCE_PATH ""
ENV REDISCACHE_HOSTNAME ""
ENV REDISCACHE_PORT ""
ENV REDISCACHE_PRIMARY_KEY ""
ENV REDISCACHE_SSLPORT ""

VOLUME /tmp

ADD build/libs/*.jar app.jar

RUN sh -c 'touch /app.jar'

ENTRYPOINT "java" "-Djava.security.egd=file:/dev/./urandom" "-Dazure.storage.account.key=$AZURE_STORAGE_ACCESS_KEY" "-Dazure.storage.account.name=$AZURE_STORAGE_ACCOUNT" "-Dazure.storage.account.blobContainer=$AZURE_STORAGE_BLOB_CONTAINER" "-Dazure.storage.account.queue=$AZURE_STORAGE_QUEUE" "-Dapplication.incidentApiUrl=$INCIDENT_API_URL" "-Dapplication.incidentResourcePath=$INCIDENT_RESOURCE_PATH" "-Dapplication.redisHost=$REDISCACHE_HOSTNAME" "-Dapplication.redisPort=$REDISCACHE_PORT" "-Dapplication.primaryKey=$REDISCACHE_PRIMARY_KEY" "-Dapplication.redisSslPort=$REDISCACHE_SSLPORT" "-jar" "/app.jar"