FROM library/ubuntu:latest  
  
RUN set -x \  
&& apt-get -yqq update \  
&& apt-get -yqq upgrade \  
&& apt-get install -yqq keepass2 libgtk2.0-0  
  
VOLUME /root/.config  
VOLUME /root/db  
  
COPY run.sh /run.sh  
RUN chmod 700 /run.sh  
  
ENTRYPOINT [ "/run.sh" ]  

