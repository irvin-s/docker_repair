FROM node:latest  
  
ENV ACCEPT_HIGHCHARTS_LICENSE YES  
  
RUN npm install highcharts-export-server@1.0.14 -g  
  
EXPOSE 7801  
CMD [ "highcharts-export-server", "--enableServer", "1" ]  

