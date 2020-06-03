# Copyright 2016, Dell, Inc.  
# Docker image for Dell Fuse Command micro service  
FROM nodesource/node:latest  
MAINTAINER Jim White <james_white2@dell.com>  
  
# environment variables  
ENV APP_TGT_DIR=/usr/src/app  
ENV APP_SRC_DIR=.  
ENV APP_PORT=4000  
EXPOSE $APP_PORT  
  
ADD $APP_SRC_DIR $APP_TGT_DIR  
  
RUN ["npm","install"]  
ENTRYPOINT ["npm","start"]  

