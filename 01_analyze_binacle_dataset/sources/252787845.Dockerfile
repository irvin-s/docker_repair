FROM iojs:2.2.1  
MAINTAINER Manuel Weidmann <weidmann.manuel@gmail.com>  
  
ADD . /home/sarapis  
  
RUN cd /home/sarapis \  
&& npm install  
  
EXPOSE 3000  
WORKDIR /home/sarapis  
  
ENTRYPOINT ["node", "sarapis.js"]

