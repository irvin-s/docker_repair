FROM onmodulus/baseimage  
  
ADD . /opt/modulus  
  
RUN /opt/modulus/bootstrap.sh  
  
CMD ["/sbin/my_init"]  

