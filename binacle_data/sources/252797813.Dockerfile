FROM ficusio/openresty  
  
  
# add gettext package for envsubst command  
RUN echo "==> Installing gettext" \  
&& apk update \  
&& apk add gettext  
  
EXPOSE 80

