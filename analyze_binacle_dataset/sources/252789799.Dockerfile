FROM node:8.2.1  
RUN apt-get update  
RUN apt-get install -y vim  
RUN apt-get install -y jq  
  
ARG wd=/home/paradox-api  
ENV wd=$wd  
  
WORKDIR $wd  
  
COPY ["node/*", "./"]  
RUN npm install  
  
EXPOSE 3000  
ENTRYPOINT ["./start.sh"]  
COPY ["docker/start.sh", "start.sh"]  
RUN ["chmod", "+x", "start.sh"]  
  

