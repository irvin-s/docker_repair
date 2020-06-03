FROM mhart/alpine-node:latest  
MAINTAINER Dan Jellesma  
  
ARG VCS_REF  
ARG BUILD_DATE  
  
RUN npm i markdown2confluence -g  
  
RUN mkdir /markdown  
WORKDIR /markdown  
COPY ./test-local.md .  
  
ENTRYPOINT ["markdown2confluence"]  
CMD ["test-local.md"]  

