FROM andlaz/hadoop-base  
MAINTAINER andras.szerdahelyi@gmail.com  
  
RUN yum -y install ruby-2.0.0.598 \  
rubygems-2.0.14  
  
RUN gem install thor  
  
ADD etc/hadoop/* /etc/hadoop/  
ADD etc/supervisor/conf.d/* /etc/supervisor/conf.d/  
  
# ( job history webapp; job history IPC )  
EXPOSE 19888 10020  
ADD configure.rb /root/  
ADD entrypoint.sh /root/  
ENTRYPOINT ["/root/entrypoint.sh"]  

