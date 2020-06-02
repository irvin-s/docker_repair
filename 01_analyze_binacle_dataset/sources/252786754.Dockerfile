FROM node:latest  
  
ENV WORKDIR=/home/node/harvest-balance  
  
WORKDIR ${WORKDIR}  
  
ADD . ${WORKDIR}  
  
RUN chown -R node:node ${WORKDIR}  
  
USER node  
  
ENV NODE_ENV development  
  
RUN yarn --pure-lockfile  
RUN CI=true yarn run test  
RUN yarn build  
  
ENV NODE_ENV production  
  
EXPOSE 5000  
CMD [ "yarn", "run", "server" ]  

