FROM haproxy:1.7  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
COPY makeconfig.sh /makeconfig.sh

