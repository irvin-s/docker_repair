FROM openjdk:8-jdk  
  
ENV SDKMAN_DIR /usr/local/sdkman  
  
RUN apt-get update && \  
apt-get install -y zip unzip && \  
apt-get upgrade && \  
apt-get clean  
  
RUN curl -s "https://get.sdkman.io" | bash  
RUN set -x \  
&& echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \  
&& echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \  
&& echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config  
  
WORKDIR $SDKMAN_DIR  
  
COPY sdkman-entrypoint.sh /  
  
ENTRYPOINT ["/sdkman-entrypoint.sh"]  
  

