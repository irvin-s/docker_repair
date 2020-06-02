FROM python:3.4  
MAINTAINER Arien Kock  
  
RUN pip install jenkins-autojobs \  
&& rm -rf /root/.cache/ \  
&& mkdir -p /var/jenkins-autojobs  
  
COPY entrypoint.sh /usr/bin/  
  
VOLUME /var/jenkins-autojobs  
  
ENTRYPOINT [ "entrypoint.sh" ]  

