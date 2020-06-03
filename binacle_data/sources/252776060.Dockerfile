FROM debian:jessie  
MAINTAINER Luke Campbell <luke.campbell@rpsgroup.com>  
  
ENV NODE_VERSION 7.9.0  
ENV GOSU_VERSION 1.9  
ENV SCRIPTS_DIR /opt/build_scripts  
  
RUN mkdir -p $SCRIPTS_DIR  
RUN useradd -m node  
  
COPY contrib/scripts/ $SCRIPTS_DIR/  
  
RUN $SCRIPTS_DIR/install-deps.sh  
RUN $SCRIPTS_DIR/install-node.sh  
COPY bin /opt/gliders/bin  
COPY public /opt/gliders/public  
COPY routes /opt/gliders/routes  
COPY views /opt/gliders/views  
COPY .bowerrc app.js bower.json package.json /opt/gliders/  
  
WORKDIR /opt/gliders  
RUN chown -R node:node /opt/gliders  
USER node  
RUN npm install && \  
node_modules/bower/bin/bower install  
  
ENV NODE_ENV production  
  
CMD ["bin/www"]  

