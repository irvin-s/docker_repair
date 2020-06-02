FROM iojs:onbuild  
RUN npm run build -- release  
  
EXPOSE 5000  
CMD npm run serve -- release  

