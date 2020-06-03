# Version: 1.0.0  
FROM brockresearch/pinebox:3.6  
MAINTAINER Brock Research  
  
RUN apk add python3=3.6.1-r3  
  
RUN apk add py3-pip  
RUN pip3 install --upgrade pip==9.0.1  
  
CMD ["/bin/sh"]

