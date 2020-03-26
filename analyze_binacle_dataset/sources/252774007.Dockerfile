FROM centos:centos7  
  
MAINTAINER XJP09_HK <jianping_xie@aliyun.com>  
  
# Add www user and group  
ENV WWW_USER www  
ENV WWW_GROUP www  
RUN groupadd -r "$WWW_GROUP" && useradd -r -M -g "$WWW_GROUP" "$WWW_USER"  
  
CMD ["/bin/bash"]  

