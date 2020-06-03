FROM node:latest  
  
# Node packages  
RUN apt-get update \  
&& apt-get install \  
bash  
RUN npm install -g n  
RUN n --version  
RUN n lts  
RUN npm install -g yarn \  
&& npm install gulp-cli -g \  
&& npm install gulp -D \  
&& npm cache clean  
  
RUN mkdir -p /var/www/app  
  
ENV WEBAPP_ROOT=/var/www/app  
ENV NPM_VERSION=lts  
ENV BUILD_SCRIPT=/var/www/app/builder/scripts/build.sh  
ENV UID=33  
ENV GID=33  
COPY scripts/build.sh /usr/bin/build.sh  
COPY scripts/docker_entrypoint.sh /usr/bin/docker_entrypoint.sh  
WORKDIR /var/www/app  
VOLUME ["/var/www/app"]  
  
ENTRYPOINT ["/usr/bin/docker_entrypoint.sh"]  
CMD /usr/bin/build.sh  

