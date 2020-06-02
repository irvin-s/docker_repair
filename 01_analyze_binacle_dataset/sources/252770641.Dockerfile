FROM swiftdocker/swift:latest  
  
RUN apt-get -y update && apt-get install -y \  
curl \  
vim \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN cd ~ \  
&& git clone https://github.com/qutheory/vapor.git \  

