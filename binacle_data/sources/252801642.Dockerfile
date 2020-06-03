FROM nginx:1.13-alpine  
  
ENV ROXY_TEMPLATE_NGINX /opt/roxy/templates/site.conf.j2  
ENV ROXY_TEMPLATE_HTML /opt/roxy/templates/index.html.j2  
ENV ROXY_BUILDER /opt/roxy/bin/app.py  
ENV ROXY_WEB_DOMAIN roxy.127.0.0.1.xip.io  
ENV ROXY_VERSION ${CACHE_TAG}  
ENV ROXY_DATA /opt/roxy/data.yml  
  
RUN \  
apk add --update \  
python \  
py-pip \  
py-yaml \  
&& pip install --upgrade pip \  
&& pip install jinja2 \  
&& rm -rf /var/cache/apk/*  
  
ADD . /opt/roxy  
ADD web /var/www  
  
RUN \  
chmod +x /opt/roxy/bin/* && \  
rm -rf /etc/nginx/conf.d/*  
  
ENTRYPOINT ["/opt/roxy/bin/entrypoint.sh"]  
  
CMD ["nginx", "-g", "daemon off;"]  

