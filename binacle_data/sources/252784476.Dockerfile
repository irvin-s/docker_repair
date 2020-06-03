# VERSION 1.0  
FROM bizztreat/docker-ruby-keboola-gd  
MAINTAINER Jiri Tobolka <jiri.tobolka@bizztreat.com>  
  
WORKDIR /home  
  
# Initialize  
# RUN gem install rest_client  
RUN git clone https://github.com/jiritobolka/gd-user-management.git ./  
RUN git checkout master  
  
ENTRYPOINT ruby ./main.rb -d /data  

