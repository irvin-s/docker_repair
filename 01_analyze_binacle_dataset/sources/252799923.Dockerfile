FROM java  
MAINTAINER Raymond Otto <otto@digiwhite.nl>  
  
ENV JMX_HOME /jmx  
  
RUN mkdir ${JMX_HOME}  
WORKDIR ${JMX_HOME}  
ADD bin ${JMX_HOME}/bin  
ADD config ${JMX_HOME}/config  
ADD entrypoint.sh ${JMX_HOME}  
  
USER nobody  
  
ENTRYPOINT ${JMX_HOME}/entrypoint.sh  

