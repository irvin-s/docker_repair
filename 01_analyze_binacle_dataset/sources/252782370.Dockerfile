FROM node:9.6  
MAINTAINER Owen Barton <owen.barton@civicactions.com>  
WORKDIR /home/node  
COPY package.json yarn.lock ./  
RUN yarn install --silent --production --non-interactive && \  
yarn cache clean --force  
COPY entrypoint.sh ./  
ENV PATH="/home/node/node_modules/.bin:${PATH}"  
EXPOSE 8000  
WORKDIR /home/node/app  
ENTRYPOINT ["/home/node/entrypoint.sh"]  

