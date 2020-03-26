FROM node:6  
MAINTAINER Luke van der Hoeven <plukevdh@articulate.com>  
  
RUN mkdir /opt/authoritah  
COPY src/ /opt/authoritah/src/  
COPY package.json /opt/authoritah  
COPY bin/authoritah /opt/authoritah/bin/  
  
WORKDIR /opt/authoritah  
RUN npm install  
RUN npm run build  
RUN npm prune --production  
  
RUN mkdir /auth0  
VOLUME /auth0  
WORKDIR /auth0  
  
ENTRYPOINT ["/opt/authoritah/bin/authoritah"]  

