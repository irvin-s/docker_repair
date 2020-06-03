FROM dockmob/java  
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>  
  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/*  
  
ADD ./setup /setup  
WORKDIR /setup  
  
RUN ./install.sh  
  
WORKDIR /usr/lib/hadoop/bin  
  
ENV DATA_DIRECTORY=/var/hadoop  
VOLUME /var/hadoop  
  
# Namenode ports  
EXPOSE 8020  
EXPOSE 50070  
# Datanode ports  
EXPOSE 50010  
EXPOSE 50020  
EXPOSE 50075  
ENTRYPOINT ["./dockmobStart.sh"]

