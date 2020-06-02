#Docker container for hmmsearch  
FROM debian  
MAINTAINER Hidemasa Bono, bonohu@gmail.com  
# copy run script  
ADD hmmsearch.sh /usr/local/bin/run.sh  
# Install packages  
RUN apt-get update && \  
apt-get install -y hmmer &&\  
apt-get install -y wget &&\  
rm -rf /var/lib/apt/lists/*  
ENTRYPOINT ["/usr/local/bin/run.sh"]  

