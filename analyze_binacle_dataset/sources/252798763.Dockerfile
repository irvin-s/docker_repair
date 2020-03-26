FROM jpetazzo/dind  
  
FROM docker:dind  
  
RUN apk add --no-cache \  
python2 \  
py-pip \  
bash \  
iptables \  
ca-certificates \  
e2fsprogs \  
&& pip install docker-compose \  
&& apk del py-pip  
  
COPY install /install/  
RUN /install/torus-cli \  
&& torus prefs set core.hints false \  
&& torus prefs set core.progress false  
  
COPY bin /usr/bin/  
  
COPY \--from=0 /usr/local/bin/wrapdocker /usr/local/bin/wrapdocker  
COPY dmsetup /usr/bin/dmsetup  
  
ENV LOG=file  
ENTRYPOINT ["wrapdocker"]  
CMD []  

