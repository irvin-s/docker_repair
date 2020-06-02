FROM node:alpine  
  
RUN npm i @dataprism/ldk && apk update && apk add bash && apk add librdkafka  
  
WORKDIR /usr/src/app  
  
ADD run.sh /  
  
RUN chmod a+x /run.sh  
  
CMD [ "/run.sh" ]

