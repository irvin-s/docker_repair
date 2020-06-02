FROM deeva/runner:latest  
  
USER root  
COPY . /home/deeva/go/src/github.com/deevatech/runner/  
RUN chown -R deeva:deeva /home/deeva/go  
  
USER deeva  
ENV GOPATH=/home/deeva/go/  
WORKDIR /home/deeva/go/src/github.com/deevatech/runner/  
RUN glide install \  
&& go build -o runner  
  
EXPOSE 8080  
CMD ./runner  
  

