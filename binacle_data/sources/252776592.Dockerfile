FROM node:8  
# 作成者情報  
MAINTAINER toshi <toshi@toshi.click>  
  
# Debian set Locale  
RUN apt-get update && \  
apt-get -y install locales task-japanese && \  
locale-gen ja_JP.UTF-8 && \  
rm -rf /var/lib/apt/lists/*  
ENV LC_ALL=ja_JP.UTF-8 \  
LC_CTYPE=ja_JP.UTF-8 \  
LANGUAGE=ja_JP:jp  
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8  
  
# Debian set TimeZone  
ENV TZ=Asia/Tokyo  
RUN echo "${TZ}" > /etc/timezone && \  
rm /etc/localtime && \  
ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \  
dpkg-reconfigure -f noninteractive tzdata  
  
# npm install  
# グローバルモジュールのインストール  
# windows環境ではローカルのみでwebpackしようとするとエラーになるのでグローバル統一  
RUN npm install yarn@1.5.1 -g && \  
npm install node-gyp@3.6.2 -g && \  
npm install node-pre-gyp@0.9.0 -g && \  
npm install webpack@4.2.0 -g && \  
npm install webpack-cli@2.0.12 -g && \  
chmod 755 /usr/local/bin/yarn  
  
RUN yarn global add node-gyp@3.6.2 && \  
yarn global add node-pre-gyp@0.9.0 && \  
yarn global add webpack@4.2.0 && \  
yarn global add webpack-cli@2.0.12  

