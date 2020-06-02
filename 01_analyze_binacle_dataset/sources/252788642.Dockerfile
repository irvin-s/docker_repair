FROM ubuntu:16.10  
MAINTAINER Chad Specter  
  
ENV METEORD_DIR /opt/meteord  
COPY scripts $METEORD_DIR  
  
ENV TZ=America/New_York  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
  
RUN bash $METEORD_DIR/init.sh  
  
#ONBUILD ADD . /opt/meteor  
#ONBUILD RUN cd /bundle/bundle/programs/server \  
# && ([ -f package.json ] || npm init -f) \  
# && npm i --loglevel=silent --unsafe-perm \  
# && npm rebuild --update-binary  
EXPOSE 80  
ENTRYPOINT bash $METEORD_DIR/run_app.sh  

