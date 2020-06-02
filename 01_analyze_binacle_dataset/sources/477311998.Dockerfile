FROM asosso/maxscale:1.4.5
MAINTAINER toughiq@gmail.com

# Setup for Galera Service (GS), not for Master-Slave environments

# We set some defaults for config creation. Can be overwritten at runtime.
ENV MAX_THREADS=4 \
    MAX_USER="maxscale" \
    MAX_PASS="maxscalepass" \
    ENABLE_ROOT_USER=0 \ 
    SPLITTER_PORT=3306 \
    ROUTER_PORT=3307 \
    CLI_PORT=6603 \
    CONNECTION_TIMEOUT=600 \
    PERSIST_POOLMAX=0 \
    PERSIST_MAXTIME=3600 \
    BACKEND_SERVER_LIST="server1 server2 server3" \
    BACKEND_SERVER_PORT="3306" \
    USE_SQL_VARIABLES_IN="all"

# We copy our config creator script to the container
COPY docker-entrypoint.sh /

# We expose our set Listener Ports
EXPOSE $SPLITTER_PORT $ROUTER_PORT $CLI_PORT

# We define the config creator as entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# We startup MaxScale as default command
CMD ["/usr/bin/maxscale","--nodaemon"]
