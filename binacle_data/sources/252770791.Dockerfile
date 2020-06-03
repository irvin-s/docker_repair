FROM agate/factual-docker-rvm-mri:2.3.1  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y git curl wget s3cmd python-pip  
RUN apt-get install -y libpq-dev libcurl4-openssl-dev libmysqlclient-dev  
RUN pip install awscli  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

