FROM python:2.7  
RUN apt-get update -qq \  
&& apt-get -y install git jq \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip install --upgrade pip  
RUN pip install awscli  
  
RUN git clone https://github.com/articulate/dynamodump.git  
WORKDIR dynamodump  
  
RUN pip install -r requirements.txt  
  
COPY entrypoint.sh /entrypoint.sh  
VOLUME "/backups"  
  
ENTRYPOINT ["/entrypoint.sh"]  

