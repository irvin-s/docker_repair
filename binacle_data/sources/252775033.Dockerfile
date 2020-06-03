FROM meteorhacks/meteord:base  
  
MAINTAINER Ben Dowling <ben.dowling@icloud.com>  
  
RUN git clone https://github.com/bd3dowling/spyfall.git /repo  
RUN cp -R /repo/spyfall /app  
RUN chmod 777 -R $METEORD_DIR  
  
ENV METEOR_ALLOW_SUPERUSER true  
  
RUN $METEORD_DIR/lib/install_meteor.sh  
RUN $METEORD_DIR/lib/build_app.sh  
  
ENV ROOT_URL http://localhost  
  
EXPOSE 80

