# Dockerfile for ESTA WebJS
FROM set_from_openshift # Wird von Openshift gesetzt
MAINTAINER Reto Lehmann <reto.lehmann@sbb.ch>

# Download sources from Repository
ADD "http://repo.sbb.ch/service/local/artifact/maven/redirect?r=mirror&g=ch.sbb.esta.webjs&a=esta-webjs-starterkit&v=$VERSION&p=tar.gz" esta-webjs-starterkit.tar.gz

# Extract and move to nginx html folder
RUN tar -xzf esta-webjs-starterkit.tar.gz
RUN mv build/* /usr/share/nginx/html

# Start nginx via script, which replaces static urls with environment variables
ADD start.sh /usr/share/nginx/start.sh
RUN chmod +x /usr/share/nginx/start.sh

# Fix permissions for runtime
RUN chmod 777 /var/log/nginx /usr/share/nginx/html

CMD /usr/share/nginx/start.sh

