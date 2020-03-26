FROM bigm/nginx

ENV NGINX_VER 1.8.0
RUN apt-get -yq --force-yes remove nginx-common
COPY nginx-common_${NGINX_VER}-1+trusty1_all.deb /nginx-common_${NGINX_VER}-1+trusty1_all.deb
COPY nginx-full_${NGINX_VER}-1+trusty1_amd64.deb /nginx-full_${NGINX_VER}-1+trusty1_amd64.deb
RUN dpkg --install /nginx-common_${NGINX_VER}-1+trusty1_all.deb \
  && dpkg --install /nginx-full_${NGINX_VER}-1+trusty1_amd64.deb \
  && rm -f /nginx-common_${NGINX_VER}-1+trusty1_all.deb \
  && rm -f /nginx-full_${NGINX_VER}-1+trusty1_amd64.deb
