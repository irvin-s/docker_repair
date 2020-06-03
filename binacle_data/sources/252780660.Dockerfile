FROM node  
MAINTAINER Copriwolf <root@or2.in>  
  
RUN mkdir -p /gitbook/docs  
WORKDIR /gitbook  
  
RUN npm install -g gitbook-cli && gitbook -V  
  
COPY ./book.json /gitbook/  
  
RUN gitbook install  
COPY ./docs/ /gitbook/docs/  
  
EXPOSE 4000  
CMD ["gitbook","serve"]  
  

