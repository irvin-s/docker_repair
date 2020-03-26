FROM deeva/manager:latest  
  
USER root  
  
COPY . /home/deeva/go/src/github.com/deevatech/manager/  
RUN chown -R deeva:deeva /home/deeva/go  
  
USER deeva  
ENV GOPATH=/home/deeva/go/  
  
WORKDIR /home/deeva/go/src/github.com/deevatech/manager/  
RUN glide install \  
&& go build -o manager  
  
EXPOSE 8080  
CMD ./manager  
  

