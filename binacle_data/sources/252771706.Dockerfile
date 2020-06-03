FROM frolvlad/alpine-mono  
  
WORKDIR /klondike  
  
RUN apk add --no-cache -v \  
python \  
py2-pip \  
git \  
tini \  
&& pip install --no-cache-dir awscli \  
&& aws --version  
  
RUN git clone https://github.com/themotleyfool/Klondike-Release .  
  
COPY Settings.config /klondike/Settings.config  
COPY run-klondike.sh /usr/bin/run-klondike.sh  
COPY s3-sync.sh /usr/bin/s3-sync.sh  
  
RUN chmod +x /usr/bin/run-klondike.sh && chmod +x /usr/bin/s3-sync.sh  
  
EXPOSE 8080  
VOLUME /klondike/data  
  
CMD ["tini", "/usr/bin/run-klondike.sh"]

