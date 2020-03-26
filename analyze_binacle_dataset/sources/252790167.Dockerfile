FROM node  
MAINTAINER Caner Candan <caner@candan.fr>  
  
WORKDIR /usr/src/app  
  
RUN git clone https://github.com/zone117x/node-open-mining-portal .  
RUN npm update  
  
ENV REDIS_HOST redis  
ENV REDIS_PORT 6379  
ENV ADMIN_PASSWORD password  
ENV STRATUM_HOST stratum.domainname.xyz  
  
ADD setup.sh /usr/src/app/  
ADD run.sh /usr/src/app/  
  
VOLUME /usr/src/app/coins  
VOLUME /usr/src/app/pool_configs  
  
EXPOSE 8888  
EXPOSE 4000  
EXPOSE 4008  
EXPOSE 4032  
EXPOSE 4256  
CMD [ "sh", "run.sh" ]  

