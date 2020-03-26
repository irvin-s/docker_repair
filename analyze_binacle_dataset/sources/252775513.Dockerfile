FROM pierrevincent/gradle-java8  
  
RUN mkdir -p /opt/hm2mqtt  
WORKDIR /opt/hm2mqtt  
  
ADD https://github.com/owagner/hm2mqtt/archive/master.tar.gz /opt/hm2mqtt/  
RUN tar xfz /opt/hm2mqtt/master.tar.gz --strip 1  
RUN ls -la /opt/hm2mqtt  
RUN gradle build  
  
ADD entrypoint.sh /opt/hm2mqtt/entrypoint.sh  
RUN chmod 777 /opt/hm2mqtt/entrypoint.sh  
  
EXPOSE 3333  
ENTRYPOINT /opt/hm2mqtt/entrypoint.sh

