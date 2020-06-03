FROM debian:8.0  
MAINTAINER andystanton  
ENV LANG C.UTF-8  
RUN apt-get update -qq && apt-get install -y patch  
ADD image-common /tmp/dexec/image-common  
VOLUME /tmp/dexec/build  
ENTRYPOINT ["/tmp/dexec/image-common/dexec-script.sh", "bash"]  

