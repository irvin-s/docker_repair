FROM ubuntu:16.04  
MAINTAINER Xiaming Chen <xiaming.chen@transwarp.io>  
  
## PREREQUESITES  
RUN apt-get update  
RUN apt-get install -y nodejs npm  
RUN apt-get install -y git git-core  
  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
RUN \  
cd /usr/local \  
&& rm -rf sprofiler \  
&& git clone http://github.com/caesar0301/sprofiler.git  
  
WORKDIR /usr/local/sprofiler  
  
RUN \  
npm install --production  
  
EXPOSE 5050  
ENV NODE_ENV=production PORT=5050  
CMD /usr/bin/npm start  

