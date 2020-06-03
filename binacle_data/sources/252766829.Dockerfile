# docker run -v ~/.aws:/tmp/dotaws:ro -it --rm --name route53 \  
# -e ROUTE53_HOSTED_ZONE_ID="ABC123XYZ"  
# -e ROUTE53_IP_ADDR="127.0.0.1"  
# -e ROUTE53_HOSTNAME="myhost.example.com"  
# alanmquach/route53-dyndns  
FROM ubuntu:xenial  
  
MAINTAINER Alan Quach <integsrtite@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
rsync \  
python-pip \  
&& pip install --upgrade awscli  
ADD update.sh /tmp/update.sh  
  
CMD ["/tmp/update.sh"]  
  

