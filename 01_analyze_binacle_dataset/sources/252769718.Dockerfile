FROM debian:jessie  
MAINTAINER Jordi Arcas "arkkanoid@gmail.com"  
RUN apt-get update && \  
apt-get install -y \  
python-pip \  
python-dev build-essential \  
&& \  
pip install boto3 pymongo\  
&& \  
rm -rf /var/lib/apt/lists/*  
  
  
ADD bin/route53-presence /bin/route53-presence  
  
ENTRYPOINT ["/bin/route53-presence"]  
CMD ["-h"]  

