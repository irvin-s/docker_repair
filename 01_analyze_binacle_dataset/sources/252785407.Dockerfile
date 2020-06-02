FROM iojs:1.6  
MAINTAINER Nick Collings <nick@ustwo.com>  
  
RUN apt-get update -qyy \  
&& apt-get install -qyy \  
vim \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /home/app/logs  
WORKDIR /home/app  
ENV TERM=xterm-256color  
ENV NODE_ENV=development  
  
COPY public /home/app/public  
COPY docs /home/app/docs  
COPY package.json /home/app/package.json  
COPY bower.json /home/app/bower.json  
COPY server /home/app/server  
COPY src /home/app/src  
COPY scripts /home/app/scripts  
  
RUN npm install \  
&& npm run-script compile \  
&& npm run-script vendors  
  
VOLUME /home/app/logs  
  
EXPOSE 8888  
CMD ["npm", "start"]  

