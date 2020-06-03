FROM mhart/alpine-node:base-7.0.0  
  
ENV PATH /root/.yarn/bin:$PATH  
  
RUN apk update \  
&& apk add curl bash binutils tar \  
&& rm -rf /var/cache/apk/* \  
&& /bin/bash \  
&& touch ~/.bashrc \  
&& curl -o- -L https://yarnpkg.com/install.sh | bash \  
&& apk del curl tar binutils  

