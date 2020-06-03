FROM ubuntu:14.04  
RUN apt-get update \  
&& apt-get install -y \  
libpoe-perl \  
libpoe-filter-ircd-perl \  
libnet-twitter-lite-perl \  
libnet-oauth-perl \  
libjson-any-perl \  
libtime-local-perl \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY . /opt/tircd/  
  
RUN sed -i 's/^address/# address/' /opt/tircd/tircd.cfg  
  
USER nobody  
  
WORKDIR /opt/tircd  
  
EXPOSE 6667  
CMD ["perl", "tircd.pl"]  

