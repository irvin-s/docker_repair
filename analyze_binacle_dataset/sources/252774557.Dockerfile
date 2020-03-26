FROM barkingiguana/base  
  
MAINTAINER Craig R Webster <craig@barkingiguana.com>  
  
RUN apt-get install -qq curl build-essential  
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby  
  
ENV PATH $PATH:/usr/local/rvm/bin  

