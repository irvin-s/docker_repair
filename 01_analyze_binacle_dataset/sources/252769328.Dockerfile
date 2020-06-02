FROM caarlos0/alpine-oraclejdk7-mvn:latest  
  
ENV LANG C.UTF-8  
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8  
  
RUN apk add --update libstdc++ git \  
&& git clone https://github.com/pinterest/secor.git secor-master \  
&& cd secor-master \  
&& mvn clean package \  
&& cd .. \  
&& mkdir -p /opt/secor \  
&& tar zxvf secor-master/target/secor-*-SNAPSHOT-bin.tar.gz -C /opt/secor \  
&& rm -fR secor-master \  
&& apk del git \  
&& rm -fR /tmp/* /var/cache/apk/*  
  
ADD run.sh /opt/secor/run.sh  
  
WORKDIR /opt/secor  
  
ENTRYPOINT ["/opt/secor/run.sh"]

