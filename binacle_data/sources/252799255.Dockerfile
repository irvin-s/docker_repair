FROM debian:8.0  
MAINTAINER andystanton  
RUN apt-get update -qq && apt-get install -y patch lua5.2  
ADD image-common /tmp/dexec/image-common  
VOLUME /tmp/dexec/build  
ENTRYPOINT ["/tmp/dexec/image-common/dexec-script.sh", "lua"]  

