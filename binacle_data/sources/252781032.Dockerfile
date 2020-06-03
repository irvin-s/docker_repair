FROM node:6.12-alpine  
  
RUN mkdir -p /app /.cache/yarn /.config/yarn/global /.yarn \  
&& chown -R 82:82 /.cache/yarn /app /.yarn /.config /usr/local  
  
WORKDIR /app  
  
USER 82  
  
RUN yarn global add gulp@4.0  

