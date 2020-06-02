FROM golang:1.7.3  
MAINTAINER Barak Bar Orion <barak.bar@gmail.com>  
  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
RUN apt-get install -y git  
  
RUN curl https://glide.sh/get | sh  
  
RUN mkdir -p /golang/pinger/src/github.com/barakb  
WORKDIR /golang/pinger/src/github.com/barakb  
  
RUN git clone https://github.com/barakb/pinger.git  
  
ENV GOPATH /golang/pinger  
WORKDIR /golang/pinger/src/github.com/barakb/pinger  
RUN glide install  
  
WORKDIR /golang/pinger  
  
RUN go build -v -o /golang/pinger/bin/pinger github.com/barakb/pinger/main  
  
WORKDIR /golang/pinger/src/github.com/barakb/pinger  
  
RUN apt-get update && apt-get install -y supervisor  
RUN mkdir -p /var/log/supervisor  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
COPY pinger.sh /golang/pinger/bin/pinger.sh  
  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]  
#CMD ["/golang/pinger/bin/pinger.sh"]  
#CMD ["bash"]  
EXPOSE 3030  

