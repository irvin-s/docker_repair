FROM alexsuch/angular-cli:latest  
  
# WORKDIR /project  
# ADD . .  
# RUN yarn install  
# RUN yarn add enhanced-resolve@3.3.0  
# RUN ng build --prod  
FROM jonnybgod/alpine-nginx:master  
  
# WORKDIR /src  
# COPY --from=0 /project/dist/ .  
# ADD ./nginx.conf /etc/nginx/nginx.conf  
RUN mkdir -p /usr/src/app  
COPY ./nginx.conf /usr/src/app  
COPY ./dist/ /usr/src/app  
WORKDIR /usr/src/app  
ADD ./nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80 443  
ENTRYPOINT ["nginx"]

