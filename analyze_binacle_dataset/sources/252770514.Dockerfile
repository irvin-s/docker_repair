# Используем за основу контейнера Ubuntu 16.04 LTS  
FROM ubuntu:16.04  
# Переключаем Ubuntu в неинтерактивный режим — чтобы избежать лишних запросов  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y python-software-properties  
RUN apt-get install -y debconf-utils  
RUN apt-get install -y software-properties-common  
RUN apt-get install locales  
RUN locale-gen ru_RU  
RUN locale-gen ru_RU.UTF-8  
RUN update-locale  
RUN dpkg-reconfigure locales  
  
#ставим ноду  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -  
RUN apt-get install -y nodejs  
RUN apt-get update --fix-missing  
RUN apt-get install -y build-essential  
RUN apt-get install -y make  
RUN npm install -g gulp  
  
RUN gulp -v  
  
RUN ls  
  
CMD ["sh", "-c", "${RUN_SCRIPT}"]  

