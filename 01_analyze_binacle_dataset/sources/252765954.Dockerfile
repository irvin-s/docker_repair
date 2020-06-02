FROM 5monkeys/node:6.4-alpine  
ENV VERSION=7.2.0  
RUN npm install -g stylelint@$VERSION  
RUN npm install -g stylelint-config-standard  
ENTRYPOINT ["stylelint"]  
CMD ["/code"]  
WORKDIR /  
VOLUME ["/code"]  

