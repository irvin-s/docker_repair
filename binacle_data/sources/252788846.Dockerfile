FROM driveclutch/infra-elasticsearch:5.4.0  
MAINTAINER David Hallum <david@driveclutch.com>  
  
RUN elasticsearch-plugin install repository-s3 \  
&& elasticsearch-plugin install discovery-ec2  
  
ENV IDX_QUEUE_SIZE 200  
COPY elasticsearch-aws.sh /elasticsearch-aws.sh  
CMD ["/elasticsearch-aws.sh"]  

