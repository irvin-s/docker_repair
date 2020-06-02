FROM alpine:latest  
MAINTAINER "Olimpiu Rob" <olimpiu.rob@eaudeweb.ro>  
  
ENV CRONUSR_HOME /opt/cronusr  
  
RUN apk add --update bash curl python3 && \  
rm -rf /var/cache/apk/* && \  
curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py" && \  
python3 /tmp/get-pip.py && \  
pip3 install chaperone  
  
RUN mkdir -p $CRONUSR_HOME/var && \  
addgroup -g 500 cronusr && \  
adduser -G cronusr -S -u 500 -h $CRONUSR_HOME -s /bin/bash cronusr && \  
chown -R 500:500 $CRONUSR_HOME  
  
RUN mkdir -p /etc/chaperone.d  
  
COPY src/chaperone.conf /etc/chaperone.d/chaperone.conf  
  
ENTRYPOINT ["/usr/bin/chaperone"]  
CMD ["--user", "cronusr"]  

