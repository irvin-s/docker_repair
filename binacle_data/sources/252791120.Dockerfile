FROM node:6.0.0-slim  
MAINTAINER cxpqwvtj@gmail.com  
  
RUN apt-get update && apt-get install -y \  
git \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN git clone https://github.com/cxpqwvtj/pocci-account-center.git  
  
RUN cd pocci-account-center \  
&& npm install  
  
WORKDIR /tmp/pocci-account-center  
  
COPY entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["node", "./server.js"]  

