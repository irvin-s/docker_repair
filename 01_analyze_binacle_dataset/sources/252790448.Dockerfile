FROM nginx:alpine  
  
RUN apk add \--update nodejs=8.9.3-r0 git  
RUN node -v && npm -v && git --version

