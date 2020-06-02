FROM ubuntu:16.04  
ARG DEV_BUILD=0  
LABEL maintainer="Matthias Leuffen <leuffen@continue.de>"  
  
WORKDIR /root/  
  
ADD .docker/.dockerfile-build.sh /root/  
RUN chmod 755 /root/.dockerfile-build.sh  
RUN /root/.dockerfile-build.sh  
  
# Aktuelles Projektverzeichnis nach /opt kopieren  
#ADD / /opt/  
ADD .docker/conf/ /  
ADD src /kicksrc  
  
ADD .docker/.dockerfile-build-configure.sh /root/  
RUN chmod 755 /root/.dockerfile-build-configure.sh  
RUN /root/.dockerfile-build-configure.sh  
  
ADD .docker/ /root/  
  
ADD .docker/entry.sh /root/  
RUN chmod 755 /root/entry.sh  
  
ADD ./doc/opt /opt  
  
ENV TIMEZONE Europe/Berlin  
ENV PULL_URL ""  
ENV ROOT_URL ""  
ENV DEV_CONTAINER_NAME "unnamed"  
ENV DEV_UID "1000"  
ENV DEV_TTYID "xXx"  
ENTRYPOINT ["/root/entry.sh"]  

