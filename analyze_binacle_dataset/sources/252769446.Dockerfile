FROM golang:1.9  
RUN go get github.com/constabulary/gb/...  
  
ENV APP_HOME /squad  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME  
  
ADD . $APP_HOME  
  
RUN gb build all  
  
CMD $APP_HOME/bin/squad  

