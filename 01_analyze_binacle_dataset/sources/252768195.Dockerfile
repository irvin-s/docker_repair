FROM node:8-alpine  
  
COPY aditosnmp/ aditosnmp/  
  
RUN cd /aditosnmp \  
&& npm i \  
&& chmod +x /aditosnmp/run.sh  
  
CMD ["/aditosnmp/run.sh"]

