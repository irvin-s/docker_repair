# Maintainers Babis Babalis, Dionysis Lappas  
FROM python:2.7.14-alpine3.6  
ENV BUILD_DEPS="gettext" \  
RUNTIME_DEPS="libintl"  
COPY . .  
ENV SRC_DIR /src  
  
RUN set -ex \  
&& pip install --no-cache-dir -r requirements.txt \  
&& apk add --update $RUNTIME_DEPS \  
&& apk add --virtual build_deps $BUILD_DEPS \  
&& cp /usr/bin/envsubst /usr/local/bin/envsubst \  
&& apk del build_deps \  
&& chmod +x ./bootscript.sh  
  
CMD ["/bootscript.sh"]  

