FROM node:0.12.7  
RUN apt-get update -y  
  
RUN git clone -b v0.7.2 https://github.com/etsy/statsd.git  
  
WORKDIR /statsd  
  
RUN wget https://github.com/anarcher/envconf/releases/download/0.0.2/envconf  
RUN chmod u+xrw ./envconf  
  
ADD ./config.js /statsd/  
  
CMD ./envconf ./config.js ; node ./stats.js ./config.js  
  

