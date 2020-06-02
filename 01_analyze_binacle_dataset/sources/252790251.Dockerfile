FROM node:6.9.2-alpine  
ENV PATH /root/.yarn/bin:$PATH  
  
RUN npm install -g firebase-tools  
  
RUN apk update \  
&& apk add curl bash binutils tar \  
&& rm -rf /var/cache/apk/* \  
&& /bin/bash \  
&& touch ~/.bashrc  
RUN curl -o- -L https://yarnpkg.com/install.sh | bash  

