FROM ubuntu  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y duplicity python-swiftclient python-keystoneclient  
  
RUN adduser --system duplicity \  
&& mkdir -p /home/duplicity/.cache/duplicity \  
&& mkdir -p /home/duplicity/.gnupg \  
&& chmod -R go+rwx /home/duplicity/  
  
ENV HOME=/home/duplicity  
  
VOLUME ["/home/duplicity/.cache/duplicity", "/home/duplicity/.gnupg"]  
  
USER duplicity  
WORKDIR "/home/duplicity"  
  
CMD ["duplicity"]  
  
  
#RUN apt-get install -y python-pip gnupg2 duplicity  
#RUN pip install python-swiftclient python-keystoneclient  

