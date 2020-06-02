FROM golang:latest  
  
MAINTAINER buckket <buckket@cock.li>  
  
ENV HTWTXT_VERSION 1.0.5  
WORKDIR $GOPATH/src/  
  
COPY ./htwtxt-${HTWTXT_VERSION}.tar.gz ./  
RUN tar xf htwtxt-${HTWTXT_VERSION}.tar.gz  
RUN ln -s htwtxt-${HTWTXT_VERSION} htwtxt  
RUN go get htwtxt  
  
RUN mkdir ~/htwtxt  
VOLUME ~/htwtxt  
  
EXPOSE 8000  
ENTRYPOINT ["htwtxt"]  

