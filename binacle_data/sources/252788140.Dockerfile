FROM node:10.3.0  
RUN apt-get update && apt-get install netcat -y  
CMD [ "node" ]

