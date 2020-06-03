FROM node:boron-alpine  
  
ENV PATH /root/.yarn/bin:$PATH  
  
RUN apk --update add git curl bash binutils tar \  
&& rm -rf /var/cache/apk/* \  
&& /bin/bash \  
&& touch ~/.bashrc \  
&& curl -o- -L https://yarnpkg.com/install.sh | bash \  
&& apk del curl tar binutils  

