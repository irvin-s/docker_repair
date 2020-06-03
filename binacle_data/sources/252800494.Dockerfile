FROM ubuntu:14.04  
MAINTAINER Lex Modyanov <lex@dominga.ru>  
  
  
RUN apt-get update  
RUN apt-get install -y python3 python3-pip  
RUN pip3 install uwsgi  
  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
ENV LC_CTYPE en_US.UTF-8  
COPY build.sh /usr/local/bin/  
RUN chmod a+x /usr/local/bin/build.sh  
  
ONBUILD COPY . /var/app  
ONBUILD WORKDIR /var/app  
ONBUILD RUN build.sh  
  
EXPOSE 9000  
CMD uwsgi --http-socket :9000 --master --module app:app --pythonpath /var/app  

