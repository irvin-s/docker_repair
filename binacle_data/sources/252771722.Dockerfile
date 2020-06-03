FROM smebberson/alpine-nginx-nodejs  
LABEL maintainer="atardadi@gmail.com"  
  
ENV root /playalong-components  
ENV NGINX_ROOT /usr/html  
  
WORKDIR ${root}  
  
#install node modules  
RUN echo 'Starting installs'  
RUN npm i -g yarn  
COPY /package.json ${root}  
RUN yarn  
  
#Copy Src files  
RUN echo 'Starting copies'  
COPY /scripts ${root}/scripts  
COPY /public ${root}/public  
COPY /config ${root}/config  
COPY /src ${root}/src  
  
EXPOSE 80  
EXPOSE 443  
# Build Playalong Components  
RUN npm run build:docs  
  
#Copy build files into nginx root folder  
RUN cd build && cp -Rf . ${NGINX_ROOT}  
  
WORKDIR ${NGINX_ROOT}  
  
# #This will run on container creation  
ENTRYPOINT nginx  

