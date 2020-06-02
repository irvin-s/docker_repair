FROM alpine:3.4  
  
MAINTAINER Cauê Alves <ceasbz2@gmail.com>  
  
RUN apk update && \  
apk upgrade && \  
apk add \--no-cache \  
curl \  
make  
  
ENV SHPEC_TESTS_FOLDER=/shpec-tests  
  
RUN mkdir -p $SHPEC_TESTS_FOLDER  
RUN sh -c "`curl -L https://raw.github.com/rylnd/shpec/master/install.sh`"  
  
CMD find $SHPEC_TESTS_FOLDER -name "*_shpec.sh" | /usr/local/bin/shpec

