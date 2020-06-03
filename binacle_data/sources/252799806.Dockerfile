FROM ubuntu:14.04  
RUN apt-get update --fix-missing  
RUN apt-get upgrade -y  
  
RUN apt-get install -y wget ca-certificates build-essential git mercurial bzr  
  
ENV PATH $PATH:/usr/local/go/bin  
ENV GOPATH /usr/local/go/  
  
RUN wget --no-verbose http://golang.org/dl/go1.3.src.tar.gz  
RUN tar -v -C /usr/local -xzf go1.3.src.tar.gz  
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1  
  
ADD register.go /tmp/  
ADD Gomfile /tmp/  
  
RUN go get github.com/mattn/gom  
RUN cd /tmp; gom install  
RUN cd /tmp; gom build register.go  
RUN cp /tmp/register /bin/register  
  
ENTRYPOINT ["/bin/register"]  

