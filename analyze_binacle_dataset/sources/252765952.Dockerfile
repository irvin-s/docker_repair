FROM 5monkeys/node:6.4-alpine  
ENV VERSION=3.8.1  
RUN npm install -g eslint@$VERSION  
RUN npm install -g eslint-config-standard \  
eslint-plugin-promise \  
eslint-plugin-standard \  
eslint-plugin-react  
ENTRYPOINT ["eslint"]  
CMD ["/code"]  
WORKDIR /  
VOLUME ["/code"]  

