FROM irakli/node-alpine:6.2

#RUN adduser -S tester
#USER tester

COPY ./ /opt/application
WORKDIR /opt/application
RUN rm -rf node_modules \ 
 && npm install

#CMD ["npm", "test"]