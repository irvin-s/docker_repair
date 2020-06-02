FROM node  
MAINTAINER "David Jay <davidgljay@gmail.com>"  
LABEL updated_at = "2015-4-11" version = .03  
LABEL description = "A service for collecting icons for tags in mayors.buzz."  
RUN apt-get update  
COPY ./ /home/mayorsdb  
WORKDIR /home/mayorsdb  
RUN npm install  
CMD node index

