FROM iojs:onbuild  
ENV NODE_ENV production  
  
ADD . /srv/dproxy  
WORKDIR /srv/dproxy  
  
RUN npm install  
CMD ["node", "/srv/dproxy/bin/dproxy"]  
  
EXPOSE 80  
EXPOSE 443

