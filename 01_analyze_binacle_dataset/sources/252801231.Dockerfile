FROM drie/lambdalike:latest  
  
USER root  
ADD package /usr/local/bin  
RUN chmod a+x /usr/local/bin/package  
RUN touch /var/lib/rpm/* && \  
yum install -y sudo python27-virtualenv zip  
  
WORKDIR /home/ec2-user  
USER ec2-user  
CMD [ "/usr/local/bin/package" ]  

