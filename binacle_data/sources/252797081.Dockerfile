FROM alpine  
MAINTAINER Justin Menga <justin.menga@gmail.com>  
  
# Install system dependencies  
RUN apk add --no-cache bash bc  
  
# Copy bats install script  
COPY bats /bats  
  
# Install bats  
RUN /bats/install.sh /usr && \  
rm -rf /bats  
  
ENTRYPOINT ["bats"]  
CMD ["/tests"]  
  
# Copy tests  
COPY tests /tests  

