FROM nginx:1.13-alpine  
  
ENV \  
BUILD_DEPS="gettext" \  
RUNTIME_DEPS="libintl"  
RUN \  
apk update && \  
apk add bash && \  
apk add --update $RUNTIME_DEPS && \  
apk add --virtual build_deps bash $BUILD_DEPS && \  
cp /usr/bin/envsubst /usr/local/bin/envsubst && \  
apk del build_deps && \  
rm -rf /var/cache/apk/*  
  
COPY bokbot-react-frontend /usr/share/nginx/html  
  
#CMD [ "/bin/bash", "/usr/share/nginx/html/assets/fuck" ]  
CMD [ "/bin/bash", "/usr/share/nginx/html/assets/start.sh" ]  

