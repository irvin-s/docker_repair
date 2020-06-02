FROM alpine  
MAINTAINER Justin Menga <justin.menga@gmail.com>  
  
# Install system dependencies  
RUN apk add --no-cache bash nodejs git  
  
COPY . /app  
WORKDIR /app  
  
# Install application dependencies  
RUN npm install -g mocha && \  
npm install  
  
# Set mocha test runner as entrypoint  
ENTRYPOINT ["mocha"]  

