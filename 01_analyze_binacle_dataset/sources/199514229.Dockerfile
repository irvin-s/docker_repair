FROM nginx

ENV ELASTICKUBE_PATH    /opt/elastickube

# Create cache folder
RUN mkdir -p /data/nginx/cache && rm -f /etc/nginx/conf.d/default.conf

WORKDIR ${ELASTICKUBE_PATH}

# Ad UI files
ADD build/ui ${ELASTICKUBE_PATH}/build/ui

# Add configuration files
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/conf.d /etc/nginx/conf.d