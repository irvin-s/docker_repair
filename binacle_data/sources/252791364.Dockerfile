FROM ubuntu:16.04  
  
RUN mkdir /proxy  
WORKDIR /proxy  
  
RUN apt-get -qy update \  
&& apt-get -qy upgrade \  
&& apt-get -qy install apache2-utils squid3  
  
COPY ./squid.conf /etc/squid  
COPY ./init .  
  
RUN chmod +x init  
  
RUN touch /etc/squid/squid_passwd  
EXPOSE 3128  
CMD ["/proxy/init"]  

