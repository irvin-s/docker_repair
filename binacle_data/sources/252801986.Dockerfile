FROM eeacms/node:v4.2.2-1.1  
ENV NODE_ENV 'production'  
ENV APP_CONFIG_DIRNAME 'default'  
ADD ./app/package.json /tmp/package.json  
ADD ./README.md /tmp/README.md  
RUN cd /tmp && npm install && mv /tmp/node_modules /node_modules  
ADD . /sources_from_git  
RUN ln -s /sources_from_git/app /code  
  
RUN chown node:node -R /node_modules/eea-searchserver/lib/framework/public/min  
  
USER node  

