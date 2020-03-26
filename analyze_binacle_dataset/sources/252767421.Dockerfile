FROM debian:jessie  
MAINTAINER Jesse Rosenberger  
  
ENV METEORD_DIR /opt/meteord  
COPY scripts $METEORD_DIR  
  
ARG NODE_VERSION  
ENV NODE_VERSION ${NODE_VERSION:-8.7.0}  
ONBUILD ENV NODE_VERSION ${NODE_VERSION:-8.7.0}  
  
RUN bash $METEORD_DIR/lib/install_base.sh  
RUN bash $METEORD_DIR/lib/install_node.sh  
RUN bash $METEORD_DIR/lib/install_phantomjs.sh  
RUN bash $METEORD_DIR/lib/cleanup.sh  
  
EXPOSE 80  
ENTRYPOINT bash $METEORD_DIR/run_app.sh  

