FROM debian  
  
RUN apt-get update && apt-get install -y \  
curl \  
wget \  
telnet \  
mysql-client \  
redis-tools \  
vim-tiny \  
awscli \  
aws-shell \  
groff \  
s3cmd \  
s3curl \  
jq \  
python3-pip  
  
RUN pip3 install csvkit  
  
# Create a symbolic link for a user's convenience  
RUN /bin/ln -s /usr/bin/vi /usr/bin/vim  

