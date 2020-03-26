FROM debian:jessie  
MAINTAINER Jesse Rosenberger  
  
ENV METEORD_DIR /opt/meteord  
COPY scripts $METEORD_DIR  
  
ARG NODE_VERSION  
ENV NODE_VERSION ${NODE_VERSION:-4.7.2}  
ONBUILD ENV NODE_VERSION ${NODE_VERSION:-4.7.2}  
  
RUN bash $METEORD_DIR/lib/install_base.sh  
RUN bash $METEORD_DIR/lib/install_node.sh  
RUN bash $METEORD_DIR/lib/install_phantomjs.sh  
RUN bash $METEORD_DIR/lib/cleanup.sh  
RUN apt-get install -qy python3  
RUN apt-get install -qy python3-pip  
RUN rm /usr/bin/python  
RUN ln -s /usr/bin/python3 /usr/bin/python  
RUN easy_install3 -U pip  
RUN pip3 install praw  
RUN pip3 install requests  
RUN pip3 install pymongo  
RUN pip3 install requests-toolbelt  
RUN pip3 install schedule  
RUN pip3 install Pillow  
  
EXPOSE 80  
ENTRYPOINT bash $METEORD_DIR/run_app.shwe  

