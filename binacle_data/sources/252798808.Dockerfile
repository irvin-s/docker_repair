FROM java:7  
# A merge of:  
# https://github.com/zhilvis/docker-h2  
# https://github.com/zilvinasu/h2-dockerfile  
MAINTAINER Oscar Fonts <oscar.fonts@geomati.co>  
  
ENV DOWNLOAD http://www.h2database.com/h2-2015-10-11.zip  
ENV DATA_DIR /opt/h2-data  
  
RUN curl ${DOWNLOAD} -o h2.zip \  
&& unzip h2.zip -d /opt/ \  
&& rm h2.zip \  
&& mkdir -p ${DATA_DIR}  
  
EXPOSE 81 1521  
CMD java -cp /opt/h2/bin/h2*.jar org.h2.tools.Server \  
-web -webAllowOthers -webPort 81 \  
-tcp -tcpAllowOthers -tcpPort 1521 \  
-baseDir ${DATA_DIR}  

