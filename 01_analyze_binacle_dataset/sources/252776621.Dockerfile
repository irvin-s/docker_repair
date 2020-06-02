FROM debian  
  
RUN apt-get -y update \  
&& apt-get -y install varnish \  
&& touch /etc/varnish/secret  
  
# Clean up our image.  
RUN rm -rf /var/lib/apt/lists/*  
  
EXPOSE 6081 6082  
COPY templates/default.vcl /etc/varnish/default.vcl  
COPY templates/custom.vcl /etc/varnish/custom.vcl  
  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
  
CMD ["/start.sh"]

