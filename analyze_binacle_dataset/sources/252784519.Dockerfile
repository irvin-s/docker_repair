FROM centos:7  
MAINTAINER Bjorn Stange <bjorn248@gmail.com>  
  
RUN yum -y install wget git  
RUN wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz  
RUN tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz  
RUN rm -f go1.5.1.linux-amd64.tar.gz  
ENV GOPATH /go  
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH  
  
RUN go get github.com/tools/godep  
  
RUN echo "Cloning Stopwatch Repo..."  
  
RUN git clone https://github.com/Bjorn248/ec2-stopwatch.git /opt/stopwatch  
  
WORKDIR /opt/stopwatch  
RUN which godep  
RUN godep restore  
RUN ./build.sh  
ADD start.sh /opt/stopwatch/start.sh  
RUN chmod +x /opt/stopwatch/start.sh  
EXPOSE 4000  
ENTRYPOINT [ "./start.sh" ]  

