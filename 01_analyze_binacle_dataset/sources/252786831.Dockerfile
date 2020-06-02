FROM node  
MAINTAINER Stefan Schindler <docker@boxbox.org>  
  
ADD source /app  
WORKDIR /app  
  
RUN npm install  
  
EXPOSE 7778  
ADD start /app/start  
RUN useradd -d /app kiwi  
RUN chown -R kiwi. /app  
  
USER kiwi  
CMD "./start"  

