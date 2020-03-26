FROM python:3.6.5  
  
ENV TZ=Asia/Shanghai  
  
COPY requirement.txt /requirement.txt  
#COPY pip.conf /root/.pip/pip.conf for mirror in China  
#COPY source.list /etc/apt/sources.list for mirror in China  
RUN pip install -r /requirement.txt  
  
  
RUN apt-get update \  
&& apt-get install -y cron \  
&& apt-get clean -y \  
&& apt-get autoclean -y \  
&& apt-get autoremove -y \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& pip install Tushare  
  
#COPY crontab /etc/cron.d/cronget  
  
  
#CMD ["cron", "-f"]  

