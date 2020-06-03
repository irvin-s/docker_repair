FROM densuke/ubuntu-jp-remix:trusty  
# supervisordを組み込んだバージョンです、/etc/supervisord.dディレクトリにiniを配置すればいろいろ動きます  
MAINTAINER densuke  
  
RUN apt-get update  
RUN apt-get install -y python curl  
RUN curl -L http://peak.telecommunity.com/dist/ez_setup.py | python -  
RUN easy_install supervisor  
RUN echo_supervisord_conf > /etc/supervisord.conf  
RUN echo "[include]" >> /etc/supervisord.conf  
RUN echo "files = /etc/supervisord.d/*.ini" >> /etc/supervisord.conf  
RUN mkdir /etc/supervisord.d  

