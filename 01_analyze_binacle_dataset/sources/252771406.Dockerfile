FROM ajnasz/node-base:1.1  
MAINTAINER Lajos Koszti <ajnasz@ajnasz.hu>  
  
RUN apk --update add git make gcc g++ python  
  
WORKDIR /app  
  
CMD ["npm", "install"]  

