FROM asuforce/puppet  
  
RUN apt update \  
&& apt install -y puppetserver=5.3.1-1xenial \  
&& apt clean \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY puppetserver /etc/default/puppetserver  
RUN puppet config set autosign true \--section master  

