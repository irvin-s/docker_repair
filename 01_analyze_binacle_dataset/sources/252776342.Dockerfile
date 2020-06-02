#Docker container for tophat  
FROM ubuntu  
MAINTAINER Hidemasa Bono, bonohu@gmail.com  
# copy run script  
ADD tophat.sh /usr/local/bin/run.sh  
# Install packages  
RUN apt-get update &&\  
apt-get install -y wget zip bzip2 &&\  
apt-get install -y tophat &&\  
apt-get install -y samtools &&\  
rm -rf /var/lib/apt/lists/*  
ENTRYPOINT ["/usr/local/bin/run.sh"]  

