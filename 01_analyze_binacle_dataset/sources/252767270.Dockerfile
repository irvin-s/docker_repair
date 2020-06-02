FROM mhart/alpine-node:4.2  
  
MAINTAINER alexellis2@gmail.com  
USER root  
  
# install app  
RUN npm install learnyounode -g  
  
# sample user  
#RUN useradd learn -m -s /bin/bash  
# set default password for logging in with bash (optional)  
#RUN echo learn:learn | chpasswd  
RUN adduser -h /home/learn learn -D  
USER learn  
  
ADD ./selector.sh /home/learn/  
  
# We will mount exercises here  
RUN mkdir /home/learn/testcases  
  
ENTRYPOINT ["/bin/sh", "/home/learn/selector.sh"]  

