#FROM node:alpine  
#MAINTAINER Carlos Yagüe, carlos.yague@upf.edu  
#RUN mkdir /home/task  
#RUN mkdir /home/input  
#RUN mkdir /home/output  
#WORKDIR /home/  
#ADD . ./task  
#WORKDIR /home/task  
#RUN rm -rf node_modules  
#RUN npm install  
#RUN npm run build  
#WORKDIR /home/  
#CMD ["sh", "-c","node /home/task/dist/index.js /home/input /home/output"]  
FROM carlosym1/dcm4chetools  
  
MAINTAINER Carlos Yagüe, carlos.yague@upf.edu  
  
# Do basic updates  
RUN apt-get update -q && apt-get clean  
# Get curl in order to download curl  
RUN apt-get install curl -y  
# Install the version of Node.js we need.  
RUN bash -c 'curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -'  
RUN apt-get install -y nodejs  
  
RUN mkdir /home/task  
  
WORKDIR /home/  
  
ADD . ./task  
  
WORKDIR /home/task  
  
RUN rm -rf node_modules  
RUN npm install  
RUN npm run build  

