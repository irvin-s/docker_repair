FROM behance/docker-base:2.3-ubuntu-18.04  
MAINTAINER Bryan Latten <latten@adobe.com>  
  
ENV CONTAINER_ROLE=web \  
CONTAINER_PORT=8080 \  
CONF_NGINX_SITE="/etc/nginx/sites-available/default" \  
CONF_NGINX_SERVER="/etc/nginx/nginx.conf" \  
NOT_ROOT_USER=www-data  
  
# Using a non-privileged port to prevent having to use setcap internally  
EXPOSE ${CONTAINER_PORT}  
  
# - Update security packages, only  
# - Install pre-reqs  
# - Install latest nginx (development PPA is actually mainline development)  
# - Perform cleanup, ensure unnecessary packages are removed  
RUN /bin/bash -e /security_updates.sh && \  
apt-get install --no-install-recommends -yqq \  
software-properties-common \  
&& \  
add-apt-repository ppa:nginx/development -y && \  
apt-get update -yqq && \  
apt-get install -yqq --no-install-recommends \  
nginx-light \  
&& \  
apt-get remove --purge -yq \  
manpages \  
manpages-dev \  
man-db \  
patch \  
make \  
unattended-upgrades \  
python* \  
&& \  
/bin/bash -e /clean.sh  
  
# Overlay the root filesystem from this repo  
COPY ./container/root /  
# Set nginx to listen on defined port  
# NOTE: order of operations is important, new config had to already installed
from repo (above)  
# - Make temp directory for .nginx runtime files  
# - Some operations can be completely removed once this ticket is resolved:  
# - https://trac.nginx.org/nginx/ticket/1243  
# - Remove older WOFF mime-type  
# - Add again with newer mime-type  
# - Also add mime-type for WOFF2  
RUN sed -i "s/listen [0-9]*;/listen ${CONTAINER_PORT};/" $CONF_NGINX_SITE && \  
mkdir /tmp/.nginx && \  
sed -i "/application\/font-woff/d" /etc/nginx/mime.types && \  
sed -i "s/}/\n font\/woff woff;&/" /etc/nginx/mime.types && \  
sed -i "s/}/\n font\/woff2 woff2;\n&/g" /etc/nginx/mime.types  
  
RUN goss -g /tests/ubuntu/nginx.goss.yaml validate && \  
/aufs_hack.sh  
  
# NOTE: intentionally NOT using s6 init as the entrypoint  
# This would prevent container debugging if any of those service crash  
CMD ["/bin/bash", "/run.sh"]  

