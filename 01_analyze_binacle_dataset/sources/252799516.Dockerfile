FROM node:8.2.1  
MAINTAINER DICEhub Team <info@dicehub.com>  
  
RUN npm config set user 0 && \  
npm config set unsafe-perm true && \  
npm install hexo-cli -g && \  
mkdir -p /home/doc  
  
WORKDIR /home/doc  
COPY package.json /home/doc  
  
RUN npm install  
  
COPY . /home/doc  
  
EXPOSE 4000  
  
CMD ["hexo", "generate"]  

