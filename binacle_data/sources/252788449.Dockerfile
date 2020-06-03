# crowleyio/node-packer  
# For more information: http://github.com/crowley-io/docker  
#  
# node-packer  
#  
# Example :  
# docker run --rm -it crowleyio/node-packer  
# VERSION 0.1.0  
FROM node:5.5.0  
MAINTAINER november-eleven  
  
RUN apt-get --purge autoremove -y \  
&& apt-get clean all \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD pack /usr/local/bin/  
RUN chmod +x /usr/local/bin/pack  
CMD ["/usr/local/bin/pack"]  

