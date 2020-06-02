FROM mysql:5.6.35  
MAINTAINER buddyingdevelopment <development@buddying.jp>  
  
# Set debian default locale to ja_JP.UTF-8  
# ref. http://qiita.com/muff1225/items/48e0753e7b745ec3ecbd  
RUN apt-get update \  
&& apt-get install -y locales \  
&& rm -rf /var/lib/apt/lists/* \  
&& echo 'ja_JP.UTF-8 UTF-8' > /etc/locale.gen \  
&& locale-gen ja_JP.UTF-8  
  
ENV LC_ALL ja_JP.UTF-8  
# Settings  
COPY ./setup/my.cnf /etc/mysql/conf.d/  

