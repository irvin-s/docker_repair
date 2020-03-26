##############################################################################  
# Copyright (c) 2017 HUAWEI TECHNOLOGIES CO.,LTD and others.  
#  
# All rights reserved. This program and the accompanying materials  
# are made available under the terms of the Apache License, Version 2.0  
# which accompanies this distribution, and is available at  
# http://www.apache.org/licenses/LICENSE-2.0  
##############################################################################  
  
FROM ubuntu:16.04  
MAINTAINER Yifei Xue <xueyifei@huawei.com>  
  
# add files  
ADD ./download_add_pkg.sh /opt/download_add_pkg.sh  
ADD ./gen_download_pkg_script.py /opt/gen_download_pkg_script.py  
ADD ./package_name.yml /opt/package_name.yml  
ADD ./download_packages.tmpl /opt/download_packages.tmpl  
ADD ./repo_task.sh /opt/repo_task.sh  
ADD ./feature_package.conf /opt/feature_package.conf  
RUN chmod +x /opt/repo_task.sh  
RUN /opt/repo_task.sh  
  
# Expose ports.  
EXPOSE 80  
EXPOSE 443  
  
# Define default command.  
CMD ["nginx", "-g", "daemon off;"]  

