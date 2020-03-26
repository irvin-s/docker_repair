FROM nbearson/centos6-python3  
  
# download gitdog-downloader  
RUN yum install -y git  
RUN pip3 install requests pymongo celery  
ADD start.sh start.sh  

