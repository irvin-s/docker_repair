FROM skynetservices/skydns  
  
MAINTAINER Christian Blades <christian.blades@careerbuilder.com>  
  
ADD ./skydnslauncher.sh .  
  
ENTRYPOINT ["./skydnslauncher.sh"]  

