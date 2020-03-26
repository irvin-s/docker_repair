FROM ubuntu  
RUN apt-get update && \  
apt-get -y install zlib1g-dev git python3 python3-pip  
  
RUN mkdir /opt/fb2mobi  
WORKDIR /opt/fb2mobi  
  
RUN git clone https://github.com/rupor-github/fb2mobi.git .  
  
RUN sed -i 's!3\\.0\\.2!3.0.1!' requirements.txt  
RUN pip3 install -r requirements.txt  
  
COPY ./kindlegen .  
COPY convert-all.sh .  
COPY fb2mobi.config .  
  
VOLUME ["/var/books"]  
WORKDIR "/var/books"  
  
CMD ["/opt/fb2mobi/convert-all.sh", "/opt/fb2mobi"]  
  

