FROM java:8-alpine

ENV DIGDAG_VERSION=0.9.35

RUN apk add --no-cache curl && \
    curl -o /usr/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/bin/digdag && \
    apk del curl && \
    adduser -h /var/lib/digdag -g 'digdag user' -s /sbin/nologin -D digdag && \
    mkdir -p /var/lib/digdag/logs/tasks /var/lib/digdag/logs/server && \
    chown -R digdag.digdag /var/lib/digdag && \
    \
    apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates curl groff less && \
    apk --no-cache add bash jq && \
    pip --no-cache-dir install awscli && \    
    rm -rf /var/cache/apk/*

COPY digdag.properties /etc/digdag.properties

USER digdag

WORKDIR /var/lib/digdag

ENV DB_TYPE=memory \
    DB_USER=digdag \
    DB_PASSWORD=digdag \
    DB_HOST=127.0.0.1 \
    DB_PORT=5432 \
    DB_NAME=digdag 

EXPOSE 65432
CMD exec digdag server --bind 0.0.0.0 \
                       --port 65432 \
                       --config /etc/digdag.properties \
		       --log /var/lib/digdag/logs/server \
		       --task-log /var/lib/digdag/logs/tasks \
                       -X database.type=$DB_TYPE \
                       -X database.user=$DB_USER \
                       -X database.password=$DB_PASSWORD \
                       -X database.host=$DB_HOST \
                       -X database.port=$DB_PORT \
                       -X database.database=$DB_NAME
