FROM crashsystems/node  
  
RUN apt-get -y install git-core  
  
RUN npm install -g hipache  
  
RUN mkdir /config  
  
ADD . /build  
  
CMD ["/build/start.sh"]  

