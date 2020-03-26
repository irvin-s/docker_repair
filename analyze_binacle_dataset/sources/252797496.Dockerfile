FROM node  
  
MAINTAINER Christopher A. Mosher <cmosher01@gmail.com>  
  
  
  
USER root  
RUN echo 'root:root' | chpasswd  
  
RUN chown -R node $(npm prefix --global)  
USER node  
ENV HOME /home/node  
WORKDIR $HOME  
  
# set up npm features  
RUN npm completion >>.bashrc  
RUN echo "alias npm-exec='PATH=$(npm bin):$PATH'" >>.bashrc  
  
# configure global defaults for npm  
RUN npm config set init.author.name "Christopher A. Mosher" \--global  
RUN npm config set init.author.email "cmosher01@gmail.com" \--global  
RUN npm config set init.license "GPL-3.0" \--global  
  
# install jspm  
RUN npm install jspm --global  
  
# set up dependencies  
USER root  
COPY package.json ./  
COPY config.js ./  
RUN chown -R node: ./  
USER node  
RUN jspm install  
  
# copy sources  
USER root  
COPY index.js ./  
COPY lib/ ./lib/  
COPY svg/ ./svg/  
RUN chown -R node: ./  
USER node  
  
  
  
# execute program  
EXPOSE 8080  
CMD jspm run index  

