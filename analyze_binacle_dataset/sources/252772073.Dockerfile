FROM augustash/alpine-base-s6:1.0.2  
# environment  
ENV VARNISH_VCL_CONF="/etc/varnish/default.vcl" \  
VARNISH_SECRET_FILE="/etc/varnish/secret" \  
VARNISH_LISTEN_PORT="80" \  
VARNISH_ADMIN_LISTEN_PORT="6082" \  
VARNISH_BACKEND_PORT="80" \  
VARNISH_BACKEND_HOST="web" \  
VARNISH_CACHE_SIZE="64M" \  
VARNISHD_PARAMS="-p default_ttl=3600 -p default_grace=3600"  
# packages & configure  
RUN apk-install pwgen varnish && \  
apk-cleanup  
  
# copy root filesystem  
COPY rootfs /  
  
# external  
EXPOSE 80 6081 6082  
# run s6 supervisor  
ENTRYPOINT ["/init"]  

