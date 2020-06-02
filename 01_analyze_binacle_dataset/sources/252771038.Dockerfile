FROM ahdinosaur/docker-gc  
MAINTAINER Michael Williams <michael.williams@enspiral.com>  
  
COPY index.sh .  
  
CMD ["sh", "./index.sh"]  

