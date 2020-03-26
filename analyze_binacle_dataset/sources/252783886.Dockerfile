FROM node:0.10  
MAINTAINER Kai Davenport <kaiyadavenport@gmail.com>  
RUN apt-get install git  
RUN mkdir /app  
RUN cd /app && git clone https://github.com/hakimel/reveal.js.git  
WORKDIR /app/reveal.js  
RUN npm install -g grunt-cli  
RUN npm install  
EXPOSE 8000  
ENTRYPOINT ["grunt", "serve"]

