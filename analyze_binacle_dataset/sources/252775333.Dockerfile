FROM iojs:2.5  
MAINTAINER Antonio Esposito "kobe@befair.it"  
COPY deps/npm /code/ui/deps/npm  
RUN npm install -g $(cat /code/ui/deps/npm)  
  
COPY deps/bower.json /code/libs/bower.json  
RUN cd /code/libs/ && bower install --allow-root  
  
EXPOSE 5000  
COPY ./ /code/ui/  
WORKDIR /code/ui/  
  
CMD ["harp", "server", "-i", "0.0.0.0", "-p", "5000", "/code"]  

