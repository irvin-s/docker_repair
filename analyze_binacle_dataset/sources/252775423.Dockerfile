FROM node:4  
MAINTAINER andras.sevcsik@screamingbox.com  
ARG GIT_COMMIT  
ENV GIT_COMMIT=unset  
ARG BUILD_DATE  
ENV BUILD_DATE=unset  
  
RUN mkdir -p /srv  
WORKDIR /srv  
COPY . /srv  
RUN npm install  
  
EXPOSE 8080  
CMD ["node", "--harmony_destructuring", "start.js", "-H0.0.0.0"]  

