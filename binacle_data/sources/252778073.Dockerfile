#  
# Alpine Linux 3.7 Dockerfile  
#  
# Pull Alpine 3.7 base image  
FROM alpine:3.7  
MAINTAINER Andreas Gerlach <info@appelgriebsch.com>  
LABEL AUTHOR="Andreas Gerlach <info@appelgriebsch.com>"  
LABEL NAME="alpine-linux"  
LABEL VERSION="3.7"  
  
USER root  
  
RUN apk update && \  
apk add bash curl && \  
rm -rf /var/cache/apk/*  
  
# add startup-scripts  
COPY scripts/*.sh /tmp/scripts/  
COPY start_instance.sh /tmp/  
COPY install_dependencies.sh /tmp/  
RUN \  
chmod 755 /tmp/start_instance.sh && \  
chmod 755 /tmp/install_dependencies.sh  
  
ONBUILD COPY dependencies.lst /tmp/  
ONBUILD RUN /tmp/install_dependencies.sh  
  
# run build  
ENTRYPOINT ["/tmp/start_instance.sh"]  
CMD ["/bin/bash"]  

