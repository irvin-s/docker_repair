FROM ubuntu:latest  
  
ADD https://deb.nodesource.com/setup_6.x /root/setup_6.x  
RUN bash /root/setup_6.x  
RUN apt-get -y upgrade  
RUN apt-get install -y firefox nodejs xvfb git bzip2 python build-essential  
ADD . /src/snap-sniff  
RUN npm install -g /src/snap-sniff  
RUN mkdir /data  
WORKDIR /data  
ENTRYPOINT ["/usr/bin/snap-sniff", "--xvfb"]  
  

