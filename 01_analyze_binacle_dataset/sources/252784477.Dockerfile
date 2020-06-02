# VERSION 1.0  
FROM bizztreat/docker-keboola-ruby-aws  
MAINTAINER Jiri Tobolka <jiri.tobolka@bizztreat.com>  
  
WORKDIR /home  
  
# Initialize  
# RUN gem install rest_client  
RUN git clone https://github.com/bizztreat/keboola-ex-segment.git ./  
RUN git checkout master  
  
ENTRYPOINT ruby ./main.rb -d /data  

