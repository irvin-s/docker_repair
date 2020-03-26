  
# Alpine-SDK Build Dockerfile  
# VERSION 3.6  
#  
# Pull Alpine Linux stable base image  
FROM appelgriebsch/alpine:3.6  
MAINTAINER Andreas Gerlach <info@appelgriebsch.com>  
LABEL AUTHOR="Andreas Gerlach <info@appelgriebsch.com>"  
LABEL NAME="alpine-sdk"  
LABEL VERSION="3.6"  
  
# build source environment variables  
# ENV GIT_REPO 'github.com/appelgriebsch/dockers.git'  
# ENV GIT_BRANCH 'master'  
# ENV GIT_USER 'appelgriebsch'  
# ENV GIT_TOKEN '<github access token>'  
# build arguments  
ENV BUILD_ARGS ''  
# project release tar.gz bundling environment variables  
ENV PROJ_NAME 'sample'  
ENV PROJ_VER '0.1.0'  
# add startup-scripts  
COPY scripts/*.sh /tmp/scripts/  
COPY start_instance.sh /tmp/  
RUN \  
chmod 755 /tmp/start_instance.sh  
  
ONBUILD COPY dependencies.lst /tmp/  
ONBUILD RUN /tmp/install_dependencies.sh  
  
# Define mountable directories.  
VOLUME /data/build  
  
# Define working directory.  
WORKDIR /data/build  
  
# run build  
ENTRYPOINT ["/tmp/start_instance.sh"]  

