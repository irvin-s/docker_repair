FROM cpro29a/ddemo_pybase  
  
MAINTAINER Sergey Melekhin <sergey@melekhin.me>  
  
ADD get_tweets.py /var/www/  
ADD docker_entrypoint.sh /var/www  
WORKDIR /var/www  
  
CMD ["/bin/sh", "docker_entrypoint.sh"]  
  

