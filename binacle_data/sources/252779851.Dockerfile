FROM node:8.9-alpine as angular-built  
LABEL authors="Brian Connell"  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
#Linux setup  
RUN apk update \  
&& apk add --update alpine-sdk \  
&& apk del alpine-sdk \  
&& rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \  
&& npm cache verify \  
&& sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd  
  
#Angular CLI  
RUN npm install -g @angular/cli@1.6.5  
COPY package.json ./  
RUN npm install --silent  
COPY . .  
RUN ng build --prod --build-optimizer  
  
#Express server =======================================  
FROM node:8.9-alpine as express-server  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY ./src/server/* /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
#COPY --from=angular-built /usr/src/app/* /usr/src/app/dist/  
#Final image ========================================  
FROM node:8.9-alpine  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY \--from=express-server /usr/src/app/ /usr/src/app/  
COPY \--from=angular-built /usr/src/app/dist/ /usr/src/app/dist/  
ENV PORT 80  
#ENV API_URL we-could-set-this-here-as-default  
CMD [ "node", "app.js" ]  
  
# no such file or directory, stat '/usr/src/app/dist/index.html'  
#no such file or directory, stat '/usr/src/app/dist/index.html'  
#no such file or directory, stat '/usr/src/app./dist/index.html'  
#: no such file or directory, stat '/usr/src/app/dist/index.html'

