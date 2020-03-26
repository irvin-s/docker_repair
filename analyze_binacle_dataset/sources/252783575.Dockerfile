FROM alpine:edge  
  
RUN apk add --no-cache \  
git \  
smartmontools \  
eudev \  
coreutils \  
bash \  
tmux \  
hdparm \  
ddrescue \  
nodejs \  
nodejs-npm  
  
WORKDIR /root/imager  
COPY package.json ./  
RUN npm install  
  
COPY .git .git  
COPY ./[^/]*.* ./  
COPY config config/  
COPY imager imager/  
COPY lib lib/  
COPY frontend frontend/  
RUN ./install.sh  
  
CMD npm start  

