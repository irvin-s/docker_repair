FROM kong:0.14.1-alpine
COPY handler.lua /usr/local/share/lua/5.1/kong/plugins/key-auth/
COPY kong.conf /etc/kong
RUN apk update && \
    apk upgrade && \
    apk add postgresql && \
    apk add postgresql-contrib && \
    apk add postgresql-client && \
    apk add nodejs-npm && \
    npm install -g kongfig && \
    mkdir /run/postgresql && \
    chown -R postgres /var/lib/postgresql && \
    chown -R postgres /run/postgresql/
    #su postgres -c 'initdb -D /var/lib/postgresql' && \
    #su postgres -c "postgres -D /var/lib/postgresql > /var/lib/postgresql/logfile 2>&1 &" && \
    #sleep 5 && \
    #su postgres && psql -c 'CREATE USER kong; CREATE DATABASE kong OWNER kong;' && \
    #kong migrations up -c /etc/kong/kong.conf && \
    #kong start -c /etc/kong/kong.conf

CMD tail -f /dev/null
