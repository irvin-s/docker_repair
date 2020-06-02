FROM tomashavlas/nginx:1.12-debian9  
  
LABEL name="bbxnet/transcode-nginx" \  
version="${NGINX_VERSION}" \  
release="1" \  
maintaner="Tomáš Havlas <havlas@bbxnet.sk>" \  
vendor="BBXNET"  
  
USER 0  
  
RUN docker-nginx-install \  
\--with-file-aio \  
\--with-http_realip_module \  
\--with-http_ssl_module \  
\--with-http_v2_module \  
\--with-threads \  
&& docker-nginx-source purge  
  
COPY [ "conf.d", "${NGINX_CONFD_PATH}" ]  
COPY [ "default.d", "${NGINX_DEFAULTD_PATH}" ]  
  
USER 48  
  
VOLUME [ "/srv/stream" ]  
  
CMD [ "run-nginx" ]  

