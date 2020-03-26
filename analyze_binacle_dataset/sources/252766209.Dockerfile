FROM node  
  
MAINTAINER [Alejandro Baez](https://twitter.com/a_baez)  
  
RUN git clone https://github.com/bitpay/copay.git /copay  
WORKDIR /copay  
  
# dependencies  
RUN npm install -g grunt-cli bower  
  
# install grunt  
RUN echo 'y' | bower install --allow-root  
  
RUN npm install  
RUN grunt  
  
EXPOSE 3000  
CMD ["npm", "start"]  

