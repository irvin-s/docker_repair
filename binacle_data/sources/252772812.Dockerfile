FROM golang  
  
RUN git clone https://github.com/mesosphere/mesos-dns.git /go/src/mesos-dns  
WORKDIR /go/src/mesos-dns  
RUN go get && go build  
  
ADD gen_mesos_dns_config.sh /  
ADD start.sh /  
  
EXPOSE 53  
CMD /start.sh  

