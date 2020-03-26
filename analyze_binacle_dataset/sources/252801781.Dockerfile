FROM node:0.12  
RUN mkdir /tmp/dredd  
RUN mkdir /dredd  
  
RUN mkdir -p /dredd/blueprints  
VOLUME /dredd/blueprints  
  
WORKDIR /tmp/dredd  
  
ADD package.json /tmp/dredd/package.json  
RUN npm install  
  
RUN ./node_modules/blueprint-transactions//scripts/build  
  
RUN mv package.json /dredd/package.json && mv node_modules /dredd/  
  
WORKDIR /dredd/node_modules/blueprint-transactions/  
  
RUN rm -fr lib && ../.bin/coffee -b -c -o lib/ src/  
  
WORKDIR /dredd  
  
ADD . /dredd  
RUN ./scripts/build  
  
WORKDIR /dredd/blueprints  
ENTRYPOINT ["/dredd/bin/dredd"]  

