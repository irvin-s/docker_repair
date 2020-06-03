FROM cotdsa/docker-predictionio:base  
MAINTAINER Matteo Sessa <webops@catchoftheday.com.au>  
  
COPY . /engine  
  
RUN cd /engine && pio build --verbose  

