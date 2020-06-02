FROM node:8  
  
LABEL maintainer="Darren Fang <idarrenfang@gmail.com>"  
  
WORKDIR /root/hexo  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
yarn global add npm && \  
yarn global add cnpm && \  
yarn global add hexo@3.5.0 && \  
yarn global add hexo-cli@1.0.4 && \  
mkdir -p /root/hexo && \  
hexo init . && \  
yarn install && \  
yarn add hexo-generator-archive@0.1.5 --save && \  
yarn add hexo-generator-category@0.1.3 --save && \  
yarn add hexo-generator-index@0.2.1 --save && \  
yarn add hexo-generator-sitemap@1.2.0 --save && \  
yarn add hexo-generator-tag@0.2.0 --save && \  
yarn add hexo-renderer-ejs@0.3.1 --save && \  
yarn add hexo-renderer-marked@0.3.2 --save && \  
yarn add hexo-renderer-stylus@0.3.3 --save && \  
yarn add hexo-server@0.3.1 --save && \  
yarn add hexo-deployer-git@0.3.1 --save && \  
yarn add hexo-generator-feed@1.2.2 --save && \  
yarn add hexo-all-minifier@0.5.2 --save && \  
rm -rf /root/hexo  
  
CMD [ "node" ]

