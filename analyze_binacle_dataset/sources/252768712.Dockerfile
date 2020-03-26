FROM andlaz/hadoop-base  
MAINTAINER andras.szerdahelyi@gmail.com  
  
RUN yum -y install ruby-2.0.0.598 \  
rubygems-2.0.14  
  
RUN gem install thor  
  
ADD etc/supervisor/conf.d/* /etc/supervisor/conf.d/  
ADD etc/hadoop/* /etc/hadoop/  
  
# System ports ( ssh )  
EXPOSE 22  
# YARN Resource Manager ports ( timeline server; timeline web app; )  
EXPOSE 10200 8188  
ADD configure.rb /root/  
ADD entrypoint.sh /root/  
ENTRYPOINT ["/root/entrypoint.sh"]  

