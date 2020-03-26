FROM blackikeeagle/alpine:3.5  
MAINTAINER Ike Devolder, ike.devolder@gmail.com  
  
ENV C_USER vimdeck  
  
COPY ./container /container  
COPY ./home /home  
RUN /container/install-vimdeck.sh  
  
ADD ./entrypoint.sh /entrypoint.sh  
  
WORKDIR /home/vimdeck  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["sh"]  

