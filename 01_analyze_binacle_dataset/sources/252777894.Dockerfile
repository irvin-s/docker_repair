FROM node:4-onbuild  
EXPOSE 80  
ENTRYPOINT ["./node_modules/.bin/boomcatch"]

