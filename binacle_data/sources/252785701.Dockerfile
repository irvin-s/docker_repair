FROM mhart/alpine-node:latest  
RUN apk update && \  
apk add --no-cache \  
g++ \  
gcc \  
git \  
libev-dev \  
libevent-dev \  
libuv-dev \  
make \  
openssl-dev \  
perl \  
python \  
curl  
WORKDIR external  
RUN npm install -g node-gyp  
WORKDIR /src  
COPY package.json .  
RUN npm install  
ADD . /src/  
RUN npm run build  
EXPOSE 8080  
EXPOSE 3030  
CMD ["npm", "run", "start"]  

