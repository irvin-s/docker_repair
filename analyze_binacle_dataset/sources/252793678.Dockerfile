FROM node:6.9-alpine  
RUN npm install -g ethereumjs-testrpc  
EXPOSE 8545  
#ENTRYPOINT [ "testrpc" ]  
CMD [ "testrpc","--gasLimit","0xFFFFFFFF" ]  

