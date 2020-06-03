FROM coorpacademy/node:8-alpine  
  
EXPOSE 4567  
ENTRYPOINT ["npm", "run", "-s", "kinesalite", "--"]  
  
CMD ["--help"]  

