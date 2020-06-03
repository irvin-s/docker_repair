## build  
FROM clojure:lein  
  
COPY . /build  
WORKDIR /build  
RUN bash ./scripts/install_node.sh  
RUN bash ./scripts/release.sh  
  
## run  
FROM node:9.2.0  
MAINTAINER Mateusz Probachta <mateusz.probachta@gmail.com>  
  
COPY \--from=0 /build/release /scene  
WORKDIR /scene  
  
RUN yarn install  
ENV HOST 0.0.0.0  
EXPOSE 3000  
CMD yarn start  

