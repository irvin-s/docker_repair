FROM fedora  
MAINTAINER Curtis Mitchell  
  
RUN dnf update -y && dnf clean all  
  
RUN dnf install -y wget tar && \  
wget -O - https://nodejs.org/dist/v4.4.4/node-v4.4.4-linux-x64.tar.gz \  
| tar xzf - --strip-components=1 --exclude="README.md" \--exclude="LICENSE" \  
\--exclude="ChangeLog" -C "/usr/local"  
  
RUN npm install -g npm  

